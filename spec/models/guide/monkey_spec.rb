require 'rails_helper'

RSpec.describe Guide::Monkey do
  let(:monkey) { described_class.new(starting_node, bouncer) }
  let(:bouncer) do
    instance_double(Guide::Bouncer,
                    :user_can_access? => true)
  end

  describe '#fetch_node' do
    subject(:fetch_node) { monkey.fetch_node(node_path) }

    context 'given a valid tree of styleguide content' do
      let(:node_path) { 'structures/checkout/page' }
      let(:starting_node) do
        instance_double(Guide::Node,
                        :id => :content,
                        :child_nodes => child_nodes)
      end
      let(:red_herring) do
        instance_double(Guide::Node,
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
                        :id => :page)
      end

      before do
        allow(bouncer).to receive(:user_can_access?).
          with(starting_node).and_return(access_starting_node?)
        allow(bouncer).to receive(:user_can_access?).
          with(child_node).and_return(access_child_node?)
        allow(bouncer).to receive(:user_can_access?).
          with(grand_child_node).and_return(access_grand_child_node?)
        allow(bouncer).to receive(:user_can_access?).
          with(leaf_node).and_return(access_leaf_node?)
      end

      let(:access_starting_node?) { true }
      let(:access_child_node?) { true }
      let(:access_grand_child_node?) { true }
      let(:access_leaf_node?) { true }

      context 'and the user can access the starting node' do
        let(:access_starting_node?) { true }

        context 'and the user can access the child node' do
          let(:access_child_node?) { true }

          context 'and the user can access the grand child node' do
            let(:access_grand_child_node?) { true }

            context 'and the user can access the leaf node' do
              let(:access_leaf_node?) { true }

              it "swings along the branches and fetches the leaf node" do
                expect(fetch_node).to be leaf_node
              end
            end

            context 'but the user cannot access the leaf node' do
              let(:access_leaf_node?) { false }

              it "screams and flings a PermissionDeniedError" do
                expect{ fetch_node }.
                  to raise_error Guide::Errors::PermissionDenied
              end
            end
          end

          context 'but the user cannot access the grand child node' do
            let(:access_grand_child_node?) { false }

            it "screams and flings a PermissionDeniedError" do
              expect{ fetch_node }.
                to raise_error Guide::Errors::PermissionDenied
            end
          end
        end

        context 'but the user cannot access the child node' do
          let(:access_child_node?) { false }

          it "screams and flings a PermissionDeniedError" do
            expect{ fetch_node }.
              to raise_error Guide::Errors::PermissionDenied
          end
        end
      end

      context 'but the user cannot access the starting node' do
        let(:access_starting_node?) { false }

        it "screams and flings a PermissionDeniedError" do
          expect{ fetch_node }.
            to raise_error Guide::Errors::PermissionDenied
        end
      end
    end

    context 'given an invalid tree of styleguide content' do
      let(:starting_node) do
        instance_double(Guide::Node,
                        :id => :content,
                        :child_nodes => {})
      end

      context 'because the starting node does not exist' do
        let(:node_path) { 'irrelevant' }
        let(:starting_node) { nil }

        it "raises an InvalidNode error and tries to explain what happened" do
          expect { fetch_node }.to raise_error(
            Guide::Errors::InvalidNode,
            I18n.t('.guide.monkey.invalid_starting_node')
          )
          expect(I18n.t('.guide.monkey.invalid_starting_node', :node_id => 'structurs')).not_to include("translation missing")
        end
      end

      context 'because a node along the path does not exist' do
        let(:node_path) { 'structures/brick/page' }

        it "raises an InvalidNode error and tries to explain what happened" do
          expect { fetch_node }.to raise_error(
            Guide::Errors::InvalidNode,
            I18n.t('.guide.monkey.invalid_node', :node_id => 'structures')
          )
          expect(I18n.t('.guide.monkey.invalid_node', :node_id => 'structurs')).not_to include("translation missing")
        end
      end
    end
  end
end
