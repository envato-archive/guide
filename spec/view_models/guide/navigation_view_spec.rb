require 'rails_helper'

RSpec.describe Guide::NavigationView do
  let(:navigation_view) do
    described_class.new(bouncer: bouncer,
                        node: node,
                        active_node: active_node)
  end
  let(:bouncer) { instance_double(Guide::Bouncer) }
  let(:node) do
    instance_double(Guide::Node,
                    :child_nodes => child_nodes,
                    :id => :structures,
                    :options => node_options)
  end
  let(:active_node) { nil }
  let(:child_nodes) do
    {
      :checkout => instance_double(Guide::Node,
                                   :id => :checkout),
      :shopping_cart => instance_double(Guide::Node,
                                        :id => :shopping_cart),
      :search_results => instance_double(Guide::Node,
                                         :id => :search_results),
    }
  end
  let(:node_options) do
    {
      :visibility => node_visibility
    }
  end
  let(:node_visibility) { nil }

  describe '#child_node_views' do
    subject(:child_node_views) { navigation_view.child_node_views }

    it "returns a collection with one #{described_class} for each child node" do
      expect(child_node_views[0]).to be_a described_class
      expect(child_node_views[0].id).to eq :checkout

      expect(child_node_views[1]).to be_a described_class
      expect(child_node_views[1].id).to eq :shopping_cart

      expect(child_node_views[2]).to be_a described_class
      expect(child_node_views[2].id).to eq :search_results
    end
  end

  describe '#visible_to_user?' do
    subject(:visible_to_user?) { navigation_view.visible_to_user? }

    context 'given that the bouncer says the user can access the node' do
      before do
        allow(bouncer).to receive(:user_can_access?).
          with(node).and_return(true)
      end

      it { is_expected.to eq true }
    end

    context 'given that the bouncer says the user cannot access the node' do
      before do
        allow(bouncer).to receive(:user_can_access?).
          with(node).and_return(false)
      end

      it { is_expected.to eq false }
    end
  end

  describe '#active?' do
    subject(:active) { navigation_view.active? }

    context 'given that the node is the active node' do
      let(:active_node) { node }

      it { is_expected.to be true }
    end

    context 'given that the node is not the active node' do
      let(:active_node) do
        instance_double(Guide::Node,
                        :child_nodes => child_nodes,
                        :id => :something_else,
                        :options => node_options)
      end

      it { is_expected.to be false }
    end
  end
end
