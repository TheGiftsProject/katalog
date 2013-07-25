Katalog::Application.routes.draw do

  resources :projects do
    get :readme
    get :changelog
    get :todo
  end

  # authentication
  match '/auth/:provider/callback', :to => 'session#create', :via => [:get, :post]
  get '/auth/destroy', :to => 'session#destroy', :as => 'sign_out'
  get '/auth/failure', :to => 'session#failure'
  get '/auth/:provider', :to => 'session#nothing', :as => 'sign_in', :defaults => {:provider => :github}
  get '/github/post_receive_hook', :to => 'github#post_receive_hook', :as => 'github_post_receive_hook'

  root :to => 'application#root'

end
