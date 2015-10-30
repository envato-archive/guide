class Guide::Document < Guide::Node
  def can_be_rendered?
    true
  end

  def partial
    "style#{self.class.to_s.underscore}"
  end
end
