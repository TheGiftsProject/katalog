Katalog::Application.routes.draw do

  root :to => 'application#root'

  resources :projects, :only => [:create, :show, :index, :edit, :update, :destroy] do
    root to: 'projects#index'

    collection do
      get :mine
      get :ideas
      get :lifted
      get :sync
      get :random
      get '/user/:username', to: :user, as: :user
    end

    member do
      post :lift
      post :like
      post :contribute
    end

    resources :posts, :only => [:create, :destroy]
    resources :users, :only => [:create, :destroy]
  end

  resource :autocomplete, :controller => 'autocomplete', :only => [] do
    get :users
    get :projects
  end

  post '/postmark', to: 'postmark#update'
  get '/slack', to: 'slack#show'
  post '/slack', to: 'slack#create'

  # authentication
  match '/auth/:provider/callback', :to => 'session#create', :via => [:get, :post]
  get '/auth/destroy', :to => 'session#destroy', :as => 'sign_out'
  get '/auth/failure', :to => 'session#failure'
  get '/auth/github', :to => 'session#nothing', :as => 'sign_in'
  post '/auth/organization', :to => 'session#organization', :as => 'organization'
  get '/auth/organization/change', :to => 'session#change_organization', :as => 'change_organization'

  get '404', :to => 'static#not_found'
  get '401', :to => 'static#not_found'
  get '403', :to => 'static#forbidden'
  get '500', :to => 'static#internal_error'
  get '422', :to => 'static#internal_error'

end
