class Guide::NodesController < Guide::BaseController
  def show
    expose_layout
    expose_navigation
    expose_node
  end

  private

  def expose_layout
    @layout_view = Guide::LayoutView.new(
      bouncer: bouncer,
      diplomat: diplomat,
      content_node: content,
      active_node: active_node,
      active_node_heritage: nobilizer.bestow_heritage(node_path),
      active_node_visibility: active_node_visibility,
      active_node_title: nobilizer.bestow_title(node_path),
    )
  end

  def expose_navigation
    @navigation_view = Guide::NavigationView.new(
      bouncer: bouncer,
      node: content,
      active_node: active_node,
    )
  end

  def expose_node
    @node_view = Guide::NodeView.new(
      node: active_node,
      bouncer: bouncer,
      diplomat: diplomat,
      node_path: node_path,
    )
  end
end
