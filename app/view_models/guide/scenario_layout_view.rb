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
    @node.layout_template
  end

  def node_layout_view
    @node.layout_view
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

  def node_layout_view_model
    @node.layout_view_model
  end
end
