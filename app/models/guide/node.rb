class Guide::Node
  class_attribute :child_nodes

  def self.inherited(sub_class)
    sub_class.child_nodes = {}
  end

  def self.contains(id, options = {})
    child_nodes[id] = child_node_class(id).new(options)
  end

  def self.child_node_class(id)
    child_node_class_name = "#{self}::#{id.to_s.camelize}"
    child_node_class_name.constantize
  rescue NameError => name_error
    raise Guide::Errors::InvalidNode,
      "I can't build the tree that backs the Styleguide because I could not load the class #{child_node_class_name}.",
      name_error.backtrace
  end

  attr_reader :id, :options

  def initialize(options = {})
    @id = infer_id_from_class_name
    @options = options
  end

  def name
    @id.to_s.titleize
  end

  def leaf_node?
    self.child_nodes.empty?
  end

  def child_nodes
    self.class.child_nodes
  end

  def ==(other)
    self.class == other.class
  end

  def node_type
    # for direct children, this will be :node
    self.class.superclass.name.demodulize.underscore.to_sym
  end

  def can_be_rendered?
    false
  end

  private

  def infer_id_from_class_name
    # for example, Structures::Checkout::Page becomes :page
    self.class.name.demodulize.underscore.to_sym
  end
end
