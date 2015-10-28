require 'rails_helper'

RSpec.describe Guide::FormObject do
  let(:form_object) { described_class.new(granted_methods) }
  let(:granted_methods) do
    {
      :granted_method => "expected reply for granted method",
    }
  end

  it "can be given methods on initialisation like an OpenStruct" do
    expect(form_object.granted_method).to eq "expected reply for granted method"
  end
end
