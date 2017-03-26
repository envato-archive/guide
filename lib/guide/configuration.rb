class Guide::Configuration
  attr_accessor :asset_path_for_logo,
    :company_name,
    :controller_class_to_inherit,
    :default_layout_for_scenarios,
    :default_javascripts_for_documents,
    :default_javascripts_for_structures,
    :default_stylesheets_for_documents,
    :default_stylesheets_for_structures,
    :guide_name,
    :helper_module_to_globally_include,
    :local_variable_for_view_model,
    :supported_locales

  def initialize
    @asset_path_for_logo = ''
    @company_name = 'Your Awesome Company'
    @controller_class_to_inherit = 'ApplicationController'
    @default_layout_for_scenarios = 'layouts/guide/scenario/default'
    @default_javascripts_for_documents = []
    @default_javascripts_for_structures = []
    @default_stylesheets_for_documents = []
    @default_stylesheets_for_structures = []
    @guide_name = 'Your Awesome Guide'
    @helper_module_to_globally_include = 'Guide::ApplicationHelper::DefaultInclude'
    @local_variable_for_view_model = :view
    @supported_locales = { "English" => "en" }
  end
end
