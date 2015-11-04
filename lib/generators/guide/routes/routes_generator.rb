class Guide::RoutesGenerator < Rails::Generators::Base
  def add_route
    route %{mount Guide::Engine => "/guide"}
  end
end
