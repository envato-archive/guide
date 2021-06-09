require 'rails_helper'

RSpec.describe 'guide/common/_navigation_node', type: :view  do
  subject(:render_navigation_node) do
    render(
      partial: 'guide/common/navigation_node',
      locals: {
        view: navigation_view,
        top_level_node: true,
        node_path: node_path,
      }
    )
  end

  let(:navigation_view) { spy(Guide::NavigationView, child_node_views: [child_navigation_view]) }
  let(:child_navigation_view) { spy(Guide::NavigationView, id: 'child-id', active?: child_active) }

  context 'given an inactive child, without node_path' do
    let(:child_active) { false }
    let(:node_path) { nil }

    it 'links to the child' do
      render_navigation_node

      expect(rendered).to include('<a href="/guide/child-id">')
    end
  end

  context 'given an inactive child, without node_path' do
    let(:child_active) { false }
    let(:node_path) { 'node-path' }

    it 'links to the child via the path' do
      render_navigation_node

      expect(rendered).to include('<a href="/guide/node-path/child-id">')
    end
  end

  context 'given an active child' do
    let(:child_active) { true }
    let(:node_path) { nil }

    it 'links to the child with active class' do
      render_navigation_node

      expect(rendered).to include('<a class="is-active" href="/guide/child-id">')
    end
  end
end
