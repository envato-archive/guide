class Guide::ScenariosController < Guide::BaseController
  layout 'guide/scenario'

  def show
    expose_layout
    expose_scenario
  end

  private

  def expose_layout
    @layout_view = Guide::ScenarioLayoutView.new(
      node: active_node,
      node_title: nobilizer.bestow_title(node_path),
      scenario: scenario,
      format: scenario_format,
      injected_html: injected_html,
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
    @scenario ||= simulator.fetch_scenario(scenario_id)
  end

  def simulator
    @simulator ||= Guide::Simulator.new(active_node, bouncer)
  end

  def scenario_id
    params[:scenario_id].to_sym
  end

  def scenario_format
    params[:scenario_format]
  end
end
