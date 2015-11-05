class Guide::ScenarioView
  def initialize(node:, scenario:, format:)
    @node = node
    @scenario = scenario
    @format = format
  end

  def uses_cells?
    @node.cell.present?
  end

  def cell
    @node.cell
  end

  def template
    @node.template || @node.partial
  end

  def format
    @format
  end

  def view
    @scenario.view
  end

  def presenter
    @scenario.presenter
  end

  def layout_css_classes
    @node.layout_css_classes || ""
  end

  def wrapper_classes
    [@scenario.options.custom_wrapper_css].join(" ") || ""
  end

end
