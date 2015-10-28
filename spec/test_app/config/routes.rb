Rails.application.routes.draw do
  mount Guide::Engine => "/guide"

  namespace 'guide', :path => nil do
    root :to => 'nodes#show'

    get 'scenario/:scenario_id/:scenario_format/for/*node_path' => 'scenarios#show', :as => 'scenario'
    get '*node_path' => 'nodes#show', :as => 'node'
  end
end
