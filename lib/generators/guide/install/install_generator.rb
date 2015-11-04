class Guide::InstallGenerator < Rails::Generators::Base
  def invoke_generators
    generate "guide:initializer"
  end
end
