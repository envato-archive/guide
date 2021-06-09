require 'rails_helper'

RSpec.describe 'guide/_content', type: :view do
  it 'links to the structures node' do
    render
    expect(rendered).to match(%r{<a class="[^"]+" href="/guide/structures">})
  end
end
