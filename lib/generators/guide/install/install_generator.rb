class Guide::InstallGenerator < Rails::Generators::Base
  def invoke_generators
    generate "guide:initializer"
    generate "guide:routes"
  end
end
