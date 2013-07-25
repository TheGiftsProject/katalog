Katalog::Application.routes.draw do

  resources :projects do
    resources :posts, :only => [:create]
  end

  resource :autocomplete, :controller => 'autocomplete', :only => [] do
    get :tags
    get :projects
  end

  # authentication
  match '/auth/:provider/callback', :to => 'session#create', :via => [:get, :post]
  get '/auth/destroy', :to => 'session#destroy', :as => 'sign_out'
  get '/auth/failure', :to => 'session#failure'
  get '/auth/:provider', :to => 'session#nothing', :as => 'sign_in', :defaults => {:provider => :github}

  root :to => 'application#root'

end
