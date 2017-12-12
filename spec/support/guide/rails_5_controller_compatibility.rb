if Rails.version >= '5'
  module Rails5ControllerCompatibility
    def get(action, params = {})
      super action, params: params
    end
  end

  RSpec.configure do |config|
    config.include Rails5ControllerCompatibility, type: :controller
  end
end
