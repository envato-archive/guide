require 'rails_helper'

RSpec.describe Guide::Bouncer do
  let(:bouncer) { described_class.new(authorisation_system) }
  let(:authorisation_system) do
    instance_double(Guide::AuthorisationSystem)
  end

  before do
    allow(authorisation_system).to receive(:allow?).
      with(:view_styleguide_unpublished).and_return(false)
    allow(authorisation_system).to receive(:allow?).
      with(:view_styleguide_restricted).and_return(false)
  end

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
            with(:view_styleguide_unpublished).and_return(true)
        end

        it { is_expected.to be true }
      end

      context 'but the user does not have permission to view unpublished nodes' do
        before do
          allow(authorisation_system).to receive(:allow?).
            with(:view_styleguide_unpublished).and_return(false)
        end

        it { is_expected.to be false }
      end

      context 'and the user has permission to view restricted nodes, but bizarrely does not have permission to view unpublished nodes' do
        before do
          allow(authorisation_system).to receive(:allow?).
            with(:view_styleguide_unpublished).and_return(false)
          allow(authorisation_system).to receive(:allow?).
            with(:view_styleguide_restricted).and_return(true)
        end

        it { is_expected.to be false }
      end
    end

    context "given that the node's visibility option is set to :restricted" do
      let(:node_visibility) { :restricted }

      context 'and the user has permission to view restricted nodes' do
        before do
          allow(authorisation_system).to receive(:allow?).
            with(:view_styleguide_restricted).and_return(true)
        end

        it { is_expected.to be true }
      end

      context 'but the user does not have permission to view restricted nodes' do
        before do
          allow(authorisation_system).to receive(:allow?).
            with(:view_styleguide_restricted).and_return(false)
        end

        it { is_expected.to be false }
      end

      context 'and the user has permission to view restricted nodes, but bizarrely does not have permission to view unpublished nodes' do
        before do
          allow(authorisation_system).to receive(:allow?).
            with(:view_styleguide_unpublished).and_return(false)
          allow(authorisation_system).to receive(:allow?).
            with(:view_styleguide_restricted).and_return(true)
        end

        it { is_expected.to be true }
      end
    end

    context 'given that the node has an invalid visibility option' do
      let(:node_visibility) { :explode_after_reading }

      it "raises a Guide::InvalidVisibilityLevelError" do
        expect{ user_can_access? }.to raise_error(Guide::Errors::InvalidVisibilityLevel)
      end

      it "provides a helpful error message" do
        expect{ user_can_access? }.to raise_error(
          Guide::Errors::InvalidVisibilityLevel,
          "You tried to give :checkout a visibility of :explode_after_reading, but :explode_after_reading is not a valid selection. Valid visibility options include: nil, :unpublished, :restricted."
        )
      end
    end
  end
end
