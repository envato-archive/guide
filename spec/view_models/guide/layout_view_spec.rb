require 'rails_helper'

RSpec.describe Guide::LayoutView do
  let(:view) do
    described_class.new(bouncer: bouncer,
                        diplomat: diplomat,
                        content_node: content_node,
                        active_node: active_node,
                        active_node_heritage: active_node_heritage,
                        active_node_visibility: active_node_visibility,
                        active_node_title: active_node_title)
  end
  let(:bouncer) { instance_double(Guide::Bouncer) }
  let(:diplomat) { instance_double(Guide::Diplomat) }
  let(:content_node) { instance_double(Guide::Node) }
  let(:active_node) { instance_double(Guide::Node) }
  let(:active_node_heritage) { 'Such » Node' }
  let(:active_node_visibility) { nil }
  let(:active_node_title) { 'Such » Node » Wow'}

  describe '#paths_to_visible_renderable_nodes' do
    let(:paths_to_visible_renderable_nodes) do
      view.paths_to_visible_renderable_nodes
    end
    let(:cartographer) { instance_double(Guide::Cartographer) }
    let(:bouncer) { instance_double(Guide::Bouncer) }

    before do
      allow(Guide::Cartographer).to receive(:new).
        with(bouncer).and_return(cartographer)
      allow(cartographer).to receive(:draw_paths_to_visible_renderable_nodes).
        with(starting_node: content_node).and_return(magical_cartography)
    end

    let(:magical_cartography) do
      {
        'such/node/wow' => 'Such » Node » Wow',
        'how/stylish' => 'How » Stylish',
        'very/leafy' => 'Very » Leafy',
      }
    end

    it "returns the cartographer's map of paths to visible leaf nodes" do
      expect(paths_to_visible_renderable_nodes).to eq magical_cartography
    end
  end
end
