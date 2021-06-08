require 'rails_helper'

RSpec.describe 'guide/scenarios/scenario/_toolbar', type: :view  do
  subject(:render_toolbar) do
    render(
      partial: 'guide/scenarios/scenario/toolbar',
      locals: {
        view: node_view,
        scenario: scenario,
        scenario_id: :scenario_id,
      }
    )
  end

  let(:node_view) { spy(Guide::NodeView, formats: [:html], node_path: :node_path) }
  let(:scenario) { spy(name: 'Default', view_model: nil, options: OpenStruct.new) }

  it 'renders link to open scenario in new tab' do
    render_toolbar
    expect(rendered).to match(%r{<a class="[^"]+" target="_blank" alt="[^"]+" href="/guide/scenario/scenario_id/html/for/node_path">})
  end
end
