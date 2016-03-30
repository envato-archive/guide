require "guide/engine"
require "guide/configuration"

module Guide
  def self.configuration
    @@configuration ||= Guide::Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
