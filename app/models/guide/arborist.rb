class Guide::Arborist
  def initialize(bouncer)
    @bouncer = bouncer
  end

  def draw_paths_to_visible_leaf_nodes(starting_node:, include_first_node: false)
    initial_node_path = include_first_node ? starting_node.id.to_s : nil

    recursively_cartograph_leaf_nodes(starting_node, initial_node_path, {})
  end

  private

  def recursively_cartograph_leaf_nodes(node, node_path, result)
    node.child_nodes.each do |child_node_id, child_node|
      child_node_path = iterate_on_node_path(node_path, child_node_id)

      if @bouncer.user_can_access?(child_node)
        if child_node.leaf_node?
          result[child_node_path] = nobilizer.bestow_title(child_node_path)
        else
          recursively_cartograph_leaf_nodes(child_node,
                                            child_node_path,
                                            result)
        end
      end
    end
    result
  end

  private

  def iterate_on_node_path(node_path, child_node_id)
    if node_path
      "#{node_path}/#{child_node_id}"
    else
      child_node_id.to_s
    end
  end

  def nobilizer
    Guide::Nobilizer.new
  end
end
