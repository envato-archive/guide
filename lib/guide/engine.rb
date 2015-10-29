module Guide
  class Engine < ::Rails::Engine
    isolate_namespace Guide

    config.generators do |g|
      g.test_framework :rspec, :fixture => false
    end
  end
end
