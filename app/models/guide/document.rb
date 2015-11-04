class Guide::Document < Guide::Node
  def node_type
    :document
  end

  def can_be_rendered?
    true
  end

  def partial
    self.class.to_s.underscore
  end
end
