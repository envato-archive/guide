class Guide::ScenarioLayoutView
  def initialize(node:, node_title:, scenario:, format:)
    @node = node
    @node_title = node_title
    @scenario = scenario
    @format = format
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

  def optional_tracking_header
    # Override this with any html injections that are used for tracking e.g. NewRelic
  end
end
