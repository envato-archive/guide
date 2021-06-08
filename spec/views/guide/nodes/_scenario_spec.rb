require 'rails_helper'

RSpec.describe 'guide/nodes/_scenario', type: :view  do
  subject(:render_scenario) do
    render(
      partial: 'guide/nodes/scenario',
      locals: {
        scenario_id: :scenario_id,
        node_path: :node_path,
        scenario_format: :scenario_format,
      }
    )
  end

  it 'renders scenario in an iframe' do
    render_scenario
    expect(rendered).to include('<iframe width="100%" scrolling="no" src="/guide/scenario/scenario_id/scenario_format/for/node_path">')
  end
end
