require 'rails_helper'

RSpec.describe Guide::Bouncer do
  let(:bouncer) do
    described_class.new(authorisation_system: authorisation_system)
  end
  let(:authorisation_system) do
    instance_double(Guide::DefaultAuthorisationSystem,
                    :user_is_privileged? => auth_user_is_privileged?,
                    :valid_visibility_options => auth_valid_visibility_options)
  end
  let(:auth_user_is_privileged?) { false }
  let(:auth_valid_visibility_options) do
    [
      nil,
      :unpublished,
      :restricted,
    ]
  end

  before do
    allow(authorisation_system).to receive(:allow?).
      with(:view_guide_unpublished).and_return(view_guide_unpublished)
    allow(authorisation_system).to receive(:allow?).
      with(:view_guide_restricted).and_return(view_guide_restricted)
  end
  let(:view_guide_unpublished) { false }
  let(:view_guide_restricted) { false }

  describe '#user_can_access?' do
    subject(:user_can_access?) { bouncer.user_can_access?(node) }

    let(:node) do
      instance_double(Guide::Node,
                      :id => :checkout,
                      :options => node_options)
    end
    let(:node_options) do
      {
        :visibility => node_visibility
      }
    end
    let(:node_visibility) { nil }

    context "given that the node's visibility option is set to nil" do
      let(:node_visibility) { nil }

      context 'and the user does not have any special permissions' do
        it { is_expected.to be true }
      end
    end

    context "given that the node's visibility option is set to :unpublished" do
      let(:node_visibility) { :unpublished }

      context 'and the user has permission to view unpublished nodes' do
        before do
          allow(authorisation_system).to receive(:allow?).
            with(:view_guide_unpublished).and_return(true)
        end

        it { is_expected.to be true }
      end

      context 'but the user does not have permission to view unpublished nodes' do
        before do
          allow(authorisation_system).to receive(:allow?).
            with(:view_guide_unpublished).and_return(false)
        end

        it { is_expected.to be false }
      end

      context 'and the user has permission to view restricted nodes, but bizarrely does not have permission to view unpublished nodes' do
        before do
          allow(authorisation_system).to receive(:allow?).
            with(:view_guide_unpublished).and_return(false)
          allow(authorisation_system).to receive(:allow?).
            with(:view_guide_restricted).and_return(true)
        end

        it { is_expected.to be false }
      end
    end

    context "given that the node's visibility option is set to :restricted" do
      let(:node_visibility) { :restricted }

      context 'and the user has permission to view restricted nodes' do
        before do
          allow(authorisation_system).to receive(:allow?).
            with(:view_guide_restricted).and_return(true)
        end

        it { is_expected.to be true }
      end

      context 'but the user does not have permission to view restricted nodes' do
        before do
          allow(authorisation_system).to receive(:allow?).
            with(:view_guide_restricted).and_return(false)
        end

        it { is_expected.to be false }
      end

      context 'and the user has permission to view restricted nodes, but bizarrely does not have permission to view unpublished nodes' do
        before do
          allow(authorisation_system).to receive(:allow?).
            with(:view_guide_unpublished).and_return(false)
          allow(authorisation_system).to receive(:allow?).
            with(:view_guide_restricted).and_return(true)
        end

        it { is_expected.to be true }
      end
    end

    context 'given that the node has an invalid visibility option' do
      let(:node_visibility) { :explode_after_reading }

      it "raises a Guide::Errors::InvalidVisibilityOption" do
        expect{ user_can_access? }.to raise_error(Guide::Errors::InvalidVisibilityOption)
      end

      it "provides a helpful error message" do
        expect{ user_can_access? }.to raise_error(
          Guide::Errors::InvalidVisibilityOption,
          "You tried to give :checkout a visibility of :explode_after_reading, but :explode_after_reading is not a valid selection. Valid visibility options include: nil, :unpublished, :restricted."
        )
      end
    end
  end

  describe "#user_is_privileged?" do
    subject(:user_is_privileged?) { bouncer.user_is_privileged? }

    context "the authorization system reports that the user is privileged" do
      let(:auth_user_is_privileged?) { true }

      it { is_expected.to be true }
    end

    context "the authorization system reports that the user is not privileged" do
      let(:auth_user_is_privileged?) { false }

      it { is_expected.to be false }
    end
  end
end
