require 'rails_helper'

RSpec.describe Guide::Nobilizer do
  let(:nobilizer) { described_class.new }

  let(:node_path) { 'such/node/wow/very/component' }

  describe '#bestow_title' do
    subject(:bestow_title) { nobilizer.bestow_title(node_path) }

    it "comes up with a knightly page title based on the node path" do
      expect(bestow_title).
        to eq "Such » Node » Wow » Very » Component"
    end
  end

  describe '#bestow_heritage' do
    subject(:bestow_heritage) { nobilizer.bestow_heritage(node_path) }

    it "comes up with a knightly page title based on the node path, minus the name of the node" do
      expect(bestow_heritage).
        to eq "Such » Node » Wow » Very"
    end
  end
end
