require 'rails_helper'

RSpec.describe Guide::Scout do
  let(:scout) { described_class.new(starting_node) }

  describe '#visibility_along_path' do
    subject(:visibility_along_path) { scout.visibility_along_path(node_path) }

    context 'given a valid tree of styleguide content' do
      let(:node_path) { 'structures/checkout/page' }
      let(:starting_node) do
        instance_double(Guide::Node,
                        :id => :content,
                        :options => {
                          :visibility => starting_node_visibility,
                        },
                        :child_nodes => child_nodes)
      end
      let(:red_herring) do
        instance_double(Guide::Node,
                        :options => {},
                        :id => :red_herring)
      end
      let(:child_nodes) do
        {
          :structures => child_node,
          :ui_library => red_herring,
        }
      end
      let(:child_node) do
        instance_double(Guide::Node,
                        :id => :structures,
                        :options => {
                          :visibility => child_node_visibility,
                        },
                        :child_nodes => grand_child_nodes)
      end
      let(:grand_child_nodes) do
        {
          :shopping_cart => red_herring,
          :checkout => grand_child_node,
          :search_results => red_herring,
        }
      end
      let(:grand_child_node) do
        instance_double(Guide::Node,
                        :id => :checkout,
                        :options => {
                          :visibility => grand_child_node_visibility,
                        },
                        :child_nodes => leaf_nodes)
      end
      let(:leaf_nodes) do
        {
          :payment_method => red_herring,
          :order_summary => red_herring,
          :page => leaf_node,
        }
      end
      let(:leaf_node) do
        instance_double(Guide::Node,
                        :options => {
                          :visibility => leaf_node_visibility,
                        },
                        :id => :page)
      end

      let(:starting_node_visibility) { nil }
      let(:child_node_visibility) { nil }
      let(:grand_child_node_visibility) { nil }
      let(:leaf_node_visibility) { nil }

      context 'and visibility of nil -> nil -> nil -> nil' do
        it "reports nil as the visibility along the path" do
          expect(visibility_along_path).to be nil
        end
      end

      context 'and visibility of :unpublished -> nil -> nil -> nil' do
        let(:starting_node_visibility) { :unpublished }

        it "reports :unpublished as the visibility along the path" do
          expect(visibility_along_path).to eq :unpublished
        end
      end

      context 'and visibility of nil -> :unpublished -> nil -> nil' do
        let(:child_node_visibility) { :unpublished }

        it "reports :unpublished as the visibility along the path" do
          expect(visibility_along_path).to eq :unpublished
        end
      end

      context 'and visibility of nil -> nil -> :unpublished -> nil' do
        let(:grand_child_node_visibility) { :unpublished }

        it "reports :unpublished as the visibility along the path" do
          expect(visibility_along_path).to eq :unpublished
        end
      end

      context 'and visibility of nil -> nil -> nil -> :unpublished' do
        let(:leaf_node_visibility) { :unpublished }

        it "reports :unpublished as the visibility along the path" do
          expect(visibility_along_path).to eq :unpublished
        end
      end

      context 'and visibility of nil -> :restricted -> nil -> :unpublished' do
        let(:child_node_visibility) { :restricted }
        let(:leaf_node_visibility) { :unpublished }

        it "reports :restricted as the visibility along the path" do
          expect(visibility_along_path).to eq :restricted
        end
      end

      context 'and visibility of nil -> :unpublished -> nil -> :restricted' do
        let(:child_node_visibility) { :unpublished }
        let(:leaf_node_visibility) { :restricted }

        it "reports :restricted as the visibility along the path" do
          expect(visibility_along_path).to eq :restricted
        end
      end

      context 'and visibility of :restricted -> :unpublished -> nil -> :unpublished' do
        let(:starting_node_visibility) { :restricted }
        let(:child_node_visibility) { :unpublished }
        let(:leaf_node_visibility) { :restricted }

        it "reports :restricted as the visibility along the path" do
          expect(visibility_along_path).to eq :restricted
        end
      end

      context 'and visibility of :nil -> :unpublished -> :restricted -> nil' do
        let(:child_node_visibility) { :unpublished }
        let(:grand_child_node_visibility) { :restricted }

        it "reports :restricted as the visibility along the path" do
          expect(visibility_along_path).to eq :restricted
        end
      end

      context 'and visibility of :nil -> :restricted -> :unpublished -> nil' do
        let(:child_node_visibility) { :restricted }
        let(:grand_child_node_visibility) { :unpublished }

        it "reports :restricted as the visibility along the path" do
          expect(visibility_along_path).to eq :restricted
        end
      end
    end

    context 'given an invalid tree of styleguide content' do
      let(:starting_node) do
        instance_double(Guide::Node,
                        :id => :content,
                        :options => {
                          :visibility => nil,
                        },
                        :child_nodes => {})
      end

      context 'because the starting node does not exist' do
        let(:node_path) { 'irrelevant' }
        let(:starting_node) { nil }

        it "raises an InvalidNode error and tries to explain what happened" do
          expect { visibility_along_path }.to raise_error(
            Guide::Errors::InvalidNode,
            "I can't give you what you're looking for because the node that you told me to start from doesn't exist. This means that something is fundamentally wrong with your setup."
          )
        end
      end

      context 'because a node along the path does not exist' do
        let(:node_path) { 'structures/brick/page' }

        it "raises an InvalidNode error and tries to explain what happened" do
          expect { visibility_along_path }.to raise_error(
            Guide::Errors::InvalidNode,
            "I can't give you what you're looking for because a node in your path (structures) doesn't exist."
          )
        end
      end
    end
  end
end
