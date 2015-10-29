class Guide::Cartographer
  def initialize(bouncer)
    @bouncer = bouncer
  end

  def draw_paths_to_visible_renderable_nodes(starting_node:)
    recursively_cartograph_visible_renderable_nodes(node: starting_node)
  end

  private

  def recursively_cartograph_visible_renderable_nodes(node:, node_path: "", result: {})
    node.child_nodes.each do |child_node_id, child_node|
      child_node_path = iterate_on_node_path(node_path: node_path,
                                             node_id: child_node_id)

      if @bouncer.user_can_access?(child_node)
        include_node_in_result_if_renderable(node: child_node,
                                             result: result,
                                             node_path: child_node_path)

        unless child_node.leaf_node?
          recursively_cartograph_visible_renderable_nodes(node: child_node,
                                                          node_path: child_node_path,
                                                          result: result)
        end
      end
    end
    result
  end

  def iterate_on_node_path(node_path:, node_id:)
    if node_path.empty?
      node_id.to_s
    else
      "#{node_path}/#{node_id}"
    end
  end

  def include_node_in_result_if_renderable(node:, node_path:, result:)
    if node.can_be_rendered?
      result[node_path] = nobilizer.bestow_title(node_path)
    end
  end

  def nobilizer
    @nobilizer ||= Guide::Nobilizer.new
  end
end
