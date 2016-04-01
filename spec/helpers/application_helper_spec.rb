require 'rails_helper'

RSpec.describe Guide::ApplicationHelper do
  describe 'inclusion of an injected helper module' do
    context 'DefaultInclude has been supplied via default guide configuration' do
      it "pulls the method into Guide::ApplicatonHelper" do
        expect(described_class.ancestors).to include(Guide::ApplicationHelper::DefaultInclude)
      end
    end
  end
end
