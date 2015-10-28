class Guide::Scout
  def initialize(starting_node)
    @starting_node = starting_node

    ensure_starting_node_exists
  end

  def visibility_along_path(node_path)
    current_node = @starting_node
    path_visibility = current_node.options[:visibility]

    node_ids_along_path(node_path).each do |node_id|
      current_node = current_node.child_nodes[node_id]
      ensure_node_exists(current_node, node_id)
      path_visibility = foggiest_visibility(path_visibility,
                                            current_node.options[:visibility])
    end

    path_visibility
  end

  private

  VISIBILITY_PRIORITY = {
    nil => 0,
    :unpublished => 1,
    :restricted => 2,
  }
  private_constant :VISIBILITY_PRIORITY

  def foggiest_visibility(first, second)
    case
    when VISIBILITY_PRIORITY[first] > VISIBILITY_PRIORITY[second]
      first
    when VISIBILITY_PRIORITY[first] < VISIBILITY_PRIORITY[second]
      second
    else
      first
    end
  end

  def node_ids_along_path(node_path)
    @node_ids ||= node_path.split("/").map {|node_id| node_id.to_sym }
  end

  def ensure_node_exists(node, node_id)
    unless node.present?
      raise Guide::Errors::InvalidNode,
        "I can't give you what you're looking for because a node in your path (#{node_id}) doesn't exist."
    end
  end

  def ensure_starting_node_exists
    unless @starting_node.present?
      raise Guide::Errors::InvalidNode,
        "I can't give you what you're looking for because the node that you told me to start from doesn't exist. This means that something is fundamentally wrong with your setup."
    end
  end
end
