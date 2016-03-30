require 'rails_helper'

RSpec.describe Guide do
  describe '.configuration' do
    it "when called multiple times, returns the same object" do
      expect(Guide.configuration).to be Guide.configuration
    end

    it "returns an instance of Guide::Configuration" do
      expect(Guide.configuration).to be_a Guide::Configuration
    end
  end

  describe '.configure' do
    it 'allows us to change configuration values' do
      expect(Guide.configuration.company_name).not_to eq "Aperture Science"

      Guide.configure do |config|
        config.company_name = "Aperture Science"
      end

      expect(Guide.configuration.company_name).to eq "Aperture Science"
    end
  end
end
