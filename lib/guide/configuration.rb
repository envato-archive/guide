class Guide::Configuration
  attr_accessor :authorisation_system_class,
    :company_name,
    :controller_class_to_inherit,
    :default_javascripts_for_documents,
    :default_javascripts_for_structures,
    :default_stylesheets_for_documents,
    :default_stylesheets_for_structures,
    :helper_module_to_globally_include,
    :local_variable_for_view_model,
    :supported_locales

  def initialize
    @authorisation_system_class = 'Guide::AuthorisationSystem::Default'
    @company_name = 'Your Awesome Company'
    @controller_class_to_inherit = 'ApplicationController'
    @default_javascripts_for_documents = []
    @default_javascripts_for_structures = []
    @default_stylesheets_for_documents = []
    @default_stylesheets_for_structures = []
    @helper_module_to_globally_include = 'Guide::ApplicationHelper::DefaultInclude'
    @local_variable_for_view_model = :view
    @supported_locales = { "English" => "en" }
  end
end
