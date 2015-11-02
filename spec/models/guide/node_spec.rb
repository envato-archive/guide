require 'rails_helper'

RSpec.describe Guide::Node do
  subject(:node) { Guide::Node.new(:root, 'root', visiblity: :published) }
  let(:child) { Guide::Node.new(:profile, 'root/profile') }
  before do
    node.child_nodes[:profile] = child
  end

  it '#name' do
    expect(subject.name).to eq "Root"
  end

  describe '#leaf_node?' do
    it 'node without child_nodes is leaf node' do
      expect(child).to be_leaf_node
    end

    it 'node with child_nodes is not leaf node' do
      expect(subject).not_to be_leaf_node
    end
  end

  describe "#==" do
    let(:another_node) { Guide::Node.new(:root, 'root') }
    
    it 'nodes with same path are equal' do
      expect(node).to eq another_node
    end
  end

  it '#can_be_rendered?' do
    expect(subject.can_be_rendered?).to eq false
  end

  describe "DSL to build nested nodes" do
    let(:check_out) { node.child_nodes[:check_out] }
    let(:paypal) { check_out.child_nodes[:paypal] }
    describe '#node' do
      it 'create nested node' do
        expect { node.node :check_out }.to change(node.child_nodes, :count).by(1)
        expect(check_out).to be_instance_of Guide::Node
        expect(check_out).not_to be_can_be_rendered
        expect(paypal).to be_nil
      end

      it 'create node recursively' do
        node.node :check_out do
          node :paypal
        end

        expect(check_out).not_to be_nil
        expect(paypal).not_to be_nil
      end
    end

    describe '#document' do
      it 'create nested node' do
        expect { node.document :check_out }.to change(node.child_nodes, :count).by(1)
        expect(check_out).to be_instance_of Guide::Document
        expect(check_out).to be_can_be_rendered
        expect(paypal).to be_nil
      end

      it 'create node recursively' do
        node.document :check_out do
          document :paypal
        end

        expect(check_out).not_to be_nil
        expect(paypal).not_to be_nil
      end
    end

    describe '#component' do
      it 'create component when correct subclass of Guide::Component defined' do
        node.component :check_out

        expect(check_out).not_to be_instance_of Guide::Component
        expect(check_out).to be_is_a Guide::Component
      end

      it 'raise exception when subclass not defined' do
        expect { node.component :check_in }.to raise_exception Guide::Errors::InvalidNode
      end
    end
  end
end

module Guide
  module Root
    class CheckOut < Guide::Component
    end
  end
end
