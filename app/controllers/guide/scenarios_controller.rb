class Guide::ScenariosController < Guide::BaseController
  # To be migrated across in a less Envato-Market-Specific form
  # layout 'guide/scenario'

  def show
    expose_layout
    expose_scenario
  rescue Guide::Errors::Base => error
    raise_error_in_dev_else_404(error)
  end

  private

  def expose_layout
    @layout_view = Guide::ScenarioLayoutView.new(
      node: active_node,
      node_title: nobilizer.bestow_title(node_path),
      scenario: scenario,
      format: scenario_format,
    )
  end

  def expose_scenario
    @scenario_view = Guide::ScenarioView.new(
      node: active_node,
      scenario: scenario,
      format: scenario_format,
    )
  end

  def scenario
    @scenario ||= active_node.scenarios[scenario_id]
  end

  def scenario_id
    params[:scenario_id].to_sym
  end

  def scenario_format
    params[:scenario_format]
  end
end
