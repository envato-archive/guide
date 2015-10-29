class Guide::Monkey
  def initialize(starting_node, bouncer)
    @starting_node = starting_node
    @bouncer = bouncer

    ensure_starting_node_exists
    ensure_user_can_access(@starting_node)
  end

  def fetch_node(node_path)
    current_node = @starting_node

    node_ids_along_path(node_path).each do |node_id|
      current_node = current_node.child_nodes[node_id]
      ensure_node_exists(current_node, node_id)
      ensure_user_can_access(current_node)
    end

    current_node
  end

  private

  def node_ids_along_path(node_path)
    node_path.split("/").map {|node_id| node_id.to_sym }
  end

  def ensure_node_exists(node, node_id)
    unless node.present?
      raise Guide::Errors::InvalidNode,
        I18n.t('.guide.monkey.invalid_node', :node_id => node_id)
    end
  end

  def ensure_starting_node_exists
    unless @starting_node.present?
      raise Guide::Errors::InvalidNode,
        I18n.t('.guide.monkey.invalid_starting_node')
    end
  end

  def ensure_user_can_access(node)
    unless @bouncer.user_can_access?(node)
      raise Guide::Errors::PermissionDenied
    end
  end
end
