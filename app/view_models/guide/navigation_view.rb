class Guide::NavigationView
  delegate :id, :name, :leaf_node?, :to => :@node

  def initialize(bouncer:, node:, active_node:)
    @bouncer = bouncer
    @node = node
    @active_node = active_node
  end

  def child_node_views
    @node.child_nodes.map do |child_node_id, child_node|
      self.class.new(bouncer: @bouncer,
                     node: child_node,
                     active_node: @active_node)
    end
  end

  def visible_to_user?
    @bouncer.user_can_access?(@node)
  end

  def active?
    @node == @active_node
  end
end
