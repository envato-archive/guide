class Guide::ViewModel < OpenStruct
  def initialize(defaults = {}, overrides = {})
    inappropriate_overrides = overrides.keys - defaults.keys
    if inappropriate_overrides.any?
      raise Guide::Errors::InterfaceViolation.new(
        "You added the #{'method'.pluralize(inappropriate_overrides.size)} [#{inappropriate_overrides.join(", ")}] to the #{self.class.name} in your scenario that #{'is'.pluralize(inappropriate_overrides.size)} not included in its official declaration (maybe in the `view_model` method on your Component)"
      )
    end

    super(defaults.merge(overrides))
  end

  def method_missing(method, *args, &block)
    raise Guide::Errors::InterfaceViolation.new(
      "You called a method '#{method}' from your template, but it does not exist on the #{self.class.name} in your Component."
    )
  end

  def to_ary
    nil # because Cells calls ViewModel#flatten for some reason
  end
end
