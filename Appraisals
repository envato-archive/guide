# FIXME: 4.2.10 Must be last otherwise:
#     Failure/Error: config.load_defaults 5.1
#     NoMethodError:
#       undefined method `load_defaults' for #<Rails::Application::Configuration:0x00007f853b582308>
#     # ./vendor/bundle/ruby/2.4.0/gems/railties-4.2.10/lib/rails/railtie/configuration.rb:95:in `method_missing'
#     # ./spec/test_apps/rails-5.1.4/config/application.rb:22:in `<class:Application>'
#     # ./spec/test_apps/rails-5.1.4/config/application.rb:20:in `<module:TestApp>'
#     # ./spec/test_apps/rails-5.1.4/config/application.rb:19:in `<top (required)>'
#     # ./spec/test_apps/rails-5.1.4/config/environment.rb:2:in `require_relative'
#     # ./spec/test_apps/rails-5.1.4/config/environment.rb:2:in `<top (required)>'
#     # ./spec/rails_helper.rb:5:in `require'
%w[
  5.1.4
  4.2.10
].each do |rails_version|
  ENV['APPRAISAL_RAILS_VERSION'] = rails_version
  appraise "rails-#{rails_version}" do
    gem 'rails', rails_version
    gem 'rails-controller-testing' if rails_version >= '5'
  end
end
