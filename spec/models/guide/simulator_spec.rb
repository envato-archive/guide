require 'rails_helper'

RSpec.describe Guide::Simulator do
  let(:simulator) { described_class.new(component, bouncer) }
  let(:bouncer) do
    instance_double(Guide::Bouncer,
                    :user_can_access? => true)
  end
  let(:component) do
    instance_double(Guide::Component,
                    :scenarios => scenarios)
  end
  let(:scenarios) do
    { :exists => scenario }
  end
  let(:scenario) { double }

  describe '#fetch_scenario' do
    subject(:fetch_scenario) { simulator.fetch_scenario(scenario_id) }

    context 'given that the scenario exists' do
      let(:scenario_id) { :exists }

      context 'given that the user is allowed to access the scenario' do
        before do
          allow(bouncer).to receive(:user_can_access?).
            with(scenario).and_return(true)
        end

        it "fetches the scenario" do
          expect(fetch_scenario).to eq scenario
        end
      end

      context 'given that the user denied access to the scenario' do
        before do
          allow(bouncer).to receive(:user_can_access?).
            with(scenario).and_return(false)
        end

        it "raises a PermissionDenied error" do
          expect { fetch_scenario }.
            to raise_error(Guide::Errors::PermissionDenied)
        end
      end
    end

    context 'given that the scenario does not exist' do
      let(:scenario_id) { :bogus }

      it "raises an InvalidScenario error" do
        expect { fetch_scenario }.
          to raise_error(Guide::Errors::InvalidScenario)
      end
    end

  end
end
