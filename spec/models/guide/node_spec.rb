require 'rails_helper'

RSpec.describe Guide::Node do
  let(:node) { Guide::Node.new }

  before do
    class WowSuchNodeSubclass < Guide::Node
      class SomeAwesomePage < Guide::Node
        def initialize(options={}); end
      end
    end
  end

  let(:child_node) { WowSuchNodeSubclass.new }

  describe ".inherited" do
    it "sets the subclass's child_nodes to an empty hash" do
      expect(WowSuchNodeSubclass.child_nodes).to be_empty
      expect(WowSuchNodeSubclass.child_nodes).to be_a Hash
    end
  end

  describe ".contains" do
    before do
      allow(WowSuchNodeSubclass::SomeAwesomePage).to receive(:new).and_return(some_awesome_page)
    end
    let(:some_awesome_page) { double }

    it "adds a key value to the child_nodes hash" do
      WowSuchNodeSubclass.contains :some_awesome_page
      expect(WowSuchNodeSubclass.child_nodes).to eq(some_awesome_page: some_awesome_page)
    end
  end

  describe ".child_node_class" do
    it "returns the class name for the child node" do
      expect(WowSuchNodeSubclass.child_node_class :some_awesome_page).to eq(
        WowSuchNodeSubclass::SomeAwesomePage
      )
    end
  end

  describe "#name" do
    subject(:name) { child_node.name }

    it "returns the titleized name of the class" do
      is_expected.to eq "Wow Such Node Subclass"
    end
  end

  describe "#leaf_node?" do
    subject(:leaf_node?) { child_node.leaf_node? }

    context "when the child node doesn't contain any further child nodes" do
      before { WowSuchNodeSubclass.child_nodes = {} }

      it { is_expected.to be true }
    end

    context "when the child node does contain further child node(s)" do
      before do
        WowSuchNodeSubclass.contains :some_awesome_page
      end

      it { is_expected.to be false }
    end
  end

  describe "#child_nodes" do
    subject(:child_nodes) { child_node.child_nodes }

    context "when the node class does not contain any child nodes" do
      before { WowSuchNodeSubclass.child_nodes = {} }
      it { is_expected.to be_empty }
    end

    context "when the node class contains child nodes" do
      before do
        allow(WowSuchNodeSubclass::SomeAwesomePage).to receive(:new).and_return(some_awesome_page)
        WowSuchNodeSubclass.contains :some_awesome_page
      end
      let(:some_awesome_page) { double }

      it "returns the child nodes of the class" do
        is_expected.to eq({some_awesome_page: some_awesome_page})
      end
    end
  end

  describe "#==" do
    subject(:==) { child_node.==(other_node) }

    context "when the objects are instances of the same class" do
      let(:other_node) { WowSuchNodeSubclass.new }

      it { is_expected.to be true }
    end

    context "when the objects are instances of the different classes" do
      let(:other_node) { double }

      it { is_expected.to be false }
    end
  end

  describe "#node_type" do
    context "when child node inherits directly from Guide::Node" do
      it "is expected to return :node" do
        expect(child_node.node_type).to eq :node
      end
    end

    context "when child node inherits indirectly from Guide::Node" do
      it "is expected to return the immediate super-class's name symbolized" do
        class GrandChild < WowSuchNodeSubclass; end
        expect(GrandChild.new.node_type).to eq :wow_such_node_subclass
      end
    end
  end

  describe "#can_be_rendered?" do
    subject(:can_be_rendered?) { child_node.can_be_rendered? }

    it { is_expected.to be false }
  end

  describe "#view_model" do
    subject(:view_model) { child_node.view_model }

    it { is_expected.to be_a Guide::ViewModel }
  end

  describe "#image_path" do
    subject(:image_path) { child_node.image_path(image_name, extension) }
    let(:image_name) { "my/awesome/image" }
    let(:extension) { "jpg" }

    before do
      allow(Guide::Photographer).to receive(:new).
        with(image_name, extension).and_return(photographer)
    end
    let(:photographer) do
      instance_double(Guide::Photographer,
                      image_path: "/images/guide/my/awesome/image.jpg")
    end

    it { is_expected.to eq "/images/guide/my/awesome/image.jpg" }
  end
end
