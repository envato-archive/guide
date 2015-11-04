class Guide::Node
  def self.child_node_class(id)
    child_node_class_name = "#{self}::#{id.to_s.camelize}"
    child_node_class_name.constantize
  rescue NameError => name_error
    raise Guide::Errors::InvalidNode,
      "I can't build the tree that backs the Styleguide because I could not load the class #{child_node_class_name}.",
      name_error.backtrace
  end

  attr_reader :id, :child_nodes, :options, :path

  def initialize(id, path, options = {})
    @id = id.to_sym
    @path = path

    @child_nodes = {}
    @options = options
  end

  def name
    @id.to_s.titleize
  end

  def leaf_node?
    child_nodes.empty?
  end

  def ==(other)
    self.path == other.path
  end

  def node_type
    :node
  end

  def can_be_rendered?
    false
  end

  # For instance_eval in DSL
  def node(child_id, child_options = {}, &block)
    create_child_node(Guide::Node, child_id, child_options, &block)
  end

  def document(child_id, child_options = {}, &block)
    create_child_node(Guide::Document, child_id, child_options, &block)
  end

  def component(child_id, child_options = {}, &block)
    create_child_node(child_component_klass(child_id), child_id, child_options, &block)
  end

  private

  def create_child_node(child_klass, child_id, child_options, &block)
    child = child_klass.new(child_id, "#{path}/#{child_id}", options.merge(child_options))
    child_nodes[child_id] = child
    child.instance_eval(&block) if block_given?
  end

  def child_component_klass(child_id)
    class_name = "Guide::#{path.split('/').push(child_id.to_s).map(&:camelize).join('::')}"
    class_name.constantize
  rescue NameError => name_error
    raise Guide::Errors::InvalidNode,
      "I can't build the tree that backs the Styleguide because I could not load the class #{class_name}",
      name_error.backtrace
  end
end
