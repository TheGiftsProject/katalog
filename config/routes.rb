Katalog::Application.routes.draw do

  resources :projects, :only => [:index, :show]

  # authentication
  match '/auth/:provider/callback', :to => 'sessions#create'
  match '/auth/failure', :to => 'sessions#failure'

  root :to => 'application#root'

end
