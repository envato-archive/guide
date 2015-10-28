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
end
