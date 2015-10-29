require 'rails_helper'

RSpec.describe Guide do

  describe '.configure' do
    it 'set default dummy company name' do
      Guide.configure {}
      expect(Guide.configuration.company_name).to eq 'Your awesome company'
    end

    it 'set company name' do
      Guide.configure do |config|
        config.company_name = 'Envato'
      end
      expect(Guide.configuration.company_name).to eq 'Envato'
    end
  end

end
