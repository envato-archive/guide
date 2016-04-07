# Code in this class ends up in Guide::BaseController
class Guide::ControllerInjection < ActionController::Base
  before_action :prepend_view_paths

  private

  def prepend_view_paths
    prepend_view_path "app/documentation"
  end
end
