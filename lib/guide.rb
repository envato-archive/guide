require "guide/engine"

module Guide
  class << self
    attr_accessor :configuration
  end

  def self.controller_class_to_inherit
    if configuration.inherit_from_application_controller
      ApplicationController
    else
      ActionController::Base
    end
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :company_name, :inherit_from_application_controller

    def initialize
      @company_name = 'Your awesome company'
      @inherit_from_application_controller = false
    end
  end
end
