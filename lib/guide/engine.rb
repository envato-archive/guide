module Guide
  class Engine < ::Rails::Engine
    isolate_namespace Guide

    config.generators do |g|
      g.test_framework :rspec, :fixture => false
    end

    initializer "guide.assets.precompile" do |app|
      app.config.assets.precompile += %w[guide/application.js guide/scenario.js guide/application.css]
    end
  end
end
