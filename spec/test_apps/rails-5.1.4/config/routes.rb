Rails.application.routes.draw do
  mount Guide::Engine => "/guide"
end
