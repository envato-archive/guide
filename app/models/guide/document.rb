class Guide::Document < Guide::Node
  def template
    partial || self.class.name.underscore
  end

  def partial
  end

  def stylesheets
    Guide.configuration.default_stylesheets_for_documents
  end

  def javascripts
    Guide.configuration.default_javascripts_for_documents
  end

  def can_be_rendered?
    true
  end
end
