Katalog::Application.routes.draw do

  root :to => 'application#root'

  resources :projects, :only => [:create, :show, :index, :edit, :update, :destroy] do

    root to: 'projects#index'
    collection do
      get :mine
      get :sync
      get '/user/:username', to: :user, as: :user
    end

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
  post '/auth/organization', :to => 'session#organization', :as => 'organization', :via => [:post]

  post '/postmark', to: 'postmark#update'

  get '404', :to => 'static#not_found'
  get '401', :to => 'static#not_found'
  get '403', :to => 'static#forbidden'
  get '500', :to => 'static#internal_error'
  get '422', :to => 'static#internal_error'

end
