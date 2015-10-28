require 'rails_helper'

RSpec.describe Guide::Cartographer do
  let(:cartographer) { described_class.new(bouncer) }
  let(:bouncer) do
    instance_double(Guide::Bouncer,
                    :user_can_access? => true)
  end

  describe '.draw_paths_to_visible_renderable_nodes' do
    let(:draw_paths_to_visible_renderable_nodes) do
      cartographer.draw_paths_to_visible_renderable_nodes(starting_node: content_node)
    end

    it "returns the relative paths to all of the visible renderable nodes, mapped to their titles" do
      expect(draw_paths_to_visible_renderable_nodes).
        to eq paths_to_all_visible_renderable_nodes
    end

    let(:paths_to_all_visible_renderable_nodes) do
      {
        'structures' => 'Structures',

        'structures/checkout' =>
        'Structures » Checkout',

        'structures/checkout/payment_method' =>
        'Structures » Checkout » Payment Method',

        'structures/checkout/order_summary' =>
        'Structures » Checkout » Order Summary',

        'structures/shopping_cart' =>
        'Structures » Shopping Cart',

        'structures/shopping_cart/not_for_sale_error' =>
        'Structures » Shopping Cart » Not For Sale Error',

        'structures/not_renderable/still_renderable' =>
        'Structures » Not Renderable » Still Renderable',
      }
    end

    before do
      allow(bouncer).to receive(:user_can_access?).
        with(off_limits_node).and_return(false)
      allow(bouncer).to receive(:user_can_access?).
        with(off_limits_component).and_return(false)
      allow(bouncer).to receive(:user_can_access?).
        with(another_off_limits_component).and_return(false)
    end

    let(:content_node) do
      instance_double(Guide::Node,
                      :id => :content,
                      :child_nodes => contents,
                      :leaf_node? => false,
                      :can_be_rendered? => true)
    end

    let(:contents) do
      {
        :structures => structures_node,
      }
    end

    let(:structures_node) do
      instance_double(Guide::Node,
                      :id => :structures,
                      :child_nodes => structures,
                      :leaf_node? => false,
                      :can_be_rendered? => true)
    end

    let(:structures) do
      {
        :checkout => checkout_node,
        :shopping_cart => shopping_cart_node,
        :not_renderable => not_renderable_node,
        :off_limits => off_limits_node,
      }
    end

    let(:checkout_node) do
      instance_double(Guide::Node,
                      :id => :checkout,
                      :child_nodes => checkout_nodes,
                      :leaf_node? => false,
                      :can_be_rendered? => true)
    end

    let(:shopping_cart_node) do
      instance_double(Guide::Node,
                      :id => :shopping_cart,
                      :child_nodes => shopping_cart_nodes,
                      :leaf_node? => false,
                      :can_be_rendered? => true)
    end

    let(:not_renderable_node) do
      instance_double(Guide::Node,
                      :id => :not_renderable,
                      :child_nodes => not_renderable_nodes,
                      :leaf_node? => false,
                      :can_be_rendered? => false)
    end

    let(:off_limits_node) do
      instance_double(Guide::Node,
                      :id => :off_limits,
                      :child_nodes => off_limits_nodes,
                      :leaf_node? => false,
                      :can_be_rendered? => true)
    end

    let(:checkout_nodes) do
      {
        :payment_method => payment_method_component,
        :order_summary => order_summary_component,
        :off_limits => off_limits_component,
      }
    end

    let(:payment_method_component) do
      instance_double(Guide::Node,
                      :id => :payment_method,
                      :leaf_node? => true,
                      :can_be_rendered? => true)
    end

    let(:order_summary_component) do
      instance_double(Guide::Node,
                      :id => :order_summary,
                      :leaf_node? => true,
                      :can_be_rendered? => true)
    end

    let(:shopping_cart_nodes) do
      {
        :not_for_sale_error => not_for_sale_error_component,
      }
    end

    let(:not_for_sale_error_component) do
      instance_double(Guide::Node,
                      :id => :not_for_sale_error,
                      :leaf_node? => true,
                      :can_be_rendered? => true)
    end

    let(:not_renderable_nodes) do
      {
        :still_renderable => still_renderable_component,
        :also_not_renderable => also_not_renderable_component,
      }
    end

    let(:still_renderable_component) do
      instance_double(Guide::Node,
                      :id => :still_renderable,
                      :leaf_node? => true,
                      :can_be_rendered? => true)
    end

    let(:also_not_renderable_component) do
      instance_double(Guide::Node,
                      :id => :also_not_renderable,
                      :leaf_node? => true,
                      :can_be_rendered? => false)
    end

    let(:off_limits_nodes) do
      {
        :off_limits => off_limits_component,
        :another_off_limits => another_off_limits_component,
      }
    end

    let(:off_limits_component) do
      instance_double(Guide::Node,
                      :id => :off_limits,
                      :leaf_node? => true,
                      :can_be_rendered? => true)
    end

    let(:another_off_limits_component) do
      instance_double(Guide::Node,
                      :id => :another_off_limits,
                      :leaf_node? => true,
                      :can_be_rendered? => true)
    end
  end
end
