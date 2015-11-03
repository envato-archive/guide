Guide.configure do |config|
  config.controller_class_to_inherit = 'ApplicationController'
end

Guide::Tree.draw do
  node :structures do
    node :purchase_flow do
      component :checkout
    end
  end
end
