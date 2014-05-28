Katalog::Application.routes.draw do

  root :to => 'application#root'

  resources :projects do
    resources :posts, :only => [:create, :destroy]
    resources :users, :only => [:destroy]
    get :bump
    get :contribute
  end

  resource :autocomplete, :controller => 'autocomplete', :only => [] do
    get :projects
    get :repositories
  end

  # authentication
  match '/auth/:provider/callback', :to => 'session#create', :via => [:get, :post]
  get '/auth/destroy', :to => 'session#destroy', :as => 'sign_out'
  get '/auth/failure', :to => 'session#failure'
  get '/auth/:provider', :to => 'session#nothing', :as => 'sign_in', :defaults => {:provider => :github}

  post '/postmark', to: 'postmark#update'
  get 'zen', :to => 'static#zen'

  get '404', :to => 'static#not_found'
  get '401', :to => 'static#not_found'
  get '403', :to => 'static#forbidden'
  get '500', :to => 'static#internal_error'
  get '422', :to => 'static#internal_error'

end
