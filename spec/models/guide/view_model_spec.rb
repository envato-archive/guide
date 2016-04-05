require 'rails_helper'

RSpec.describe Guide::ViewModel do
  let(:view_model) { described_class.new(granted_methods) }
  let(:granted_methods) do
    {
      :granted_method => "expected reply for granted method",
    }
  end

  it "can be given methods on initialisation like an OpenStruct" do
    expect(view_model.granted_method).to eq "expected reply for granted method"
  end

  context 'when a missing method is called' do
    it 'raises an InterfaceViolation error' do
      expect { view_model.invalid_method }.
        to raise_error(Guide::Errors::InterfaceViolation)
    end
  end

  describe '#guide_view_model_interface_methods' do
    let(:granted_methods) do
      {
        :granted_method => "expected reply for granted method",
        :other_granted_method => "expected reply for other granted method"
      }
    end

    it "returns a list of the methods that we given it" do
      expect(view_model.guide_view_model_interface_methods).to eq [:granted_method, :other_granted_method]
    end
  end
end
