Guide::Engine.routes.draw do
  root :to => 'nodes#show'

  get 'scenario/:scenario_id/:scenario_format/for/*node_path' => 'scenarios#show', :as => 'scenario'
  get '*node_path' => 'nodes#show', :as => 'node'
end
