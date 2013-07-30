Katalog::Application.routes.draw do

  resources :projects do
    resources :posts, :only => [:create]

    scope :controller => :github_hook do
      post :post_receive_hook
    end
    scope :controller => :github_pages do
      get :readme
      get :changelog
      get :todo
    end
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

  get '404', :to => 'static#not_found'
  get '401', :to => 'static#not_found'
  get '403', :to => 'static#forbidden'
  get '500', :to => 'static#internal_error'
  get '422', :to => 'static#internal_error'

end
