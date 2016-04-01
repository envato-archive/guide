module Guide::ApplicationHelper
  module DefaultInclude; end
  include Guide.configuration.helper_module_to_globally_include.constantize
end
