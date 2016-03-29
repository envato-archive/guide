class Guide::Configuration
  attr_accessor :company_name,
    :controller_class_to_inherit,
    :supported_locales,
    :authorisation_system_class,
    :local_variable_for_view_model,
    :default_stylesheets_for_structures,
    :default_javascripts_for_structures,
    :default_stylesheets_for_documents,
    :default_javascripts_for_documents

  def initialize
    @company_name = 'Your Awesome Company'
    @controller_class_to_inherit = 'ApplicationController'
    @supported_locales = { "English" => "en" }
    @authorisation_system_class = 'Guide::AuthorisationSystem::Default'
    @local_variable_for_view_model = :view
    @default_stylesheets_for_structures = []
    @default_javascripts_for_structures = []
    @default_stylesheets_for_documents = []
    @default_javascripts_for_documents = []
  end
end
