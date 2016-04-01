class Guide::ScenarioLayoutView
  def initialize(node:, node_title:, scenario:, format:, injected_html:)
    @node = node
    @node_title = node_title
    @scenario = scenario
    @format = format
    @injected_html = injected_html
  end

  def node_title
    @node_title
  end

  def scenario_name
    @scenario.name
  end

  def node_layout_template
    @node.layout_templates[format] || Guide.configuration.default_layout_for_scenarios
  end

  def node_layout_view
    @node.layout_view_model
  end

  def format
    @format
  end

  def node_stylesheets
    @node.stylesheets
  end

  def node_javascripts
    @node.javascripts
  end

  def injected_html
    @injected_html.html_safe
  end
end
