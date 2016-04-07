require 'rails_helper'

RSpec.describe Guide::DefaultAuthorisationSystem do
  let(:authorisation_system) { Guide::DefaultAuthorisationSystem.new }

  describe "#allow?" do
    subject(:allow?) { authorisation_system.allow?(action) }
    let(:action) { spy }

    it { is_expected.to be true }
  end
end
