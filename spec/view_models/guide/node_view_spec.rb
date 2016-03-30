require 'rails_helper'

RSpec.describe Guide::NodeView do
  let(:view) do
    described_class.new(node: structure,
                        diplomat: diplomat,
                        bouncer: bouncer,
                        node_path: node_path)
  end
  let(:structure) do
    instance_double(Guide::Structure,
                    :scenarios => scenarios)
  end
  let(:bouncer) { instance_double(Guide::Bouncer) }
  let(:diplomat) { instance_double(Guide::Diplomat) }
  let(:node_path) { 'such/node/wow' }

  let(:scenarios) do
    {
      :such_scenario => such_scenario,
      :very_informative => very_informative,
      :wow => wow,
    }
  end

  let(:such_scenario) { double }
  let(:very_informative) { double }
  let(:wow) { double }

  describe '#visible_scenarios' do
    subject(:visible_scenarios) { view.visible_scenarios }

    context 'given that the bouncer says that the user can access such_scenario' do
      before do
        allow(bouncer).to receive(:user_can_access?).
          with(such_scenario).and_return(true)
      end

      context 'and the bouncer says that the user can access very_informative' do
        before do
          allow(bouncer).to receive(:user_can_access?).
            with(very_informative).and_return(true)
        end

        context 'but the bouncer says that the user cannot access wow' do
          before do
            allow(bouncer).to receive(:user_can_access?).
              with(wow).and_return(false)
          end

          it "returns such_scenario and very_informative but not wow" do
            expect(visible_scenarios).to eq(
              {
                :such_scenario => such_scenario,
                :very_informative => very_informative,
              }
            )
          end
        end
      end
    end

    context 'given that the bouncer says that the user cannot access such_scenario' do
      before do
        allow(bouncer).to receive(:user_can_access?).
          with(such_scenario).and_return(false)
      end

      context 'and the bouncer says that the user cannot access very_informative either' do
        before do
          allow(bouncer).to receive(:user_can_access?).
            with(very_informative).and_return(false)
        end

        context 'but the bouncer says that the user can access wow' do
          before do
            allow(bouncer).to receive(:user_can_access?).
              with(wow).and_return(true)
          end

          it "returns only wow" do
            expect(visible_scenarios).to eq({:wow => wow})
          end
        end
      end
    end
  end
end
