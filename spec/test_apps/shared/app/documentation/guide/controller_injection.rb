# Code in this class ends up in Guide::BaseController
class Guide::ControllerInjection < ActionController::Base
  prepend_view_path 'app/documentation'
end
