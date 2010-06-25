ActionController::Routing::Routes.draw do |map|
  map.devise_for :clients
  map.resources :home, :only => :index
  
  map.root :controller => :home

  map.resources :games  

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'

end
