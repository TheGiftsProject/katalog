Katalog::Application.routes.draw do

  resources :projects, :only => [:index, :show]

  # authentication
  resource :session, :only => [:destroy], :controller => :session, :as => 'sign_out'
  get '/auth/:provider', :to => 'session#nothing', :as => 'sign_in', :default => [:provider => :github]
  match '/auth/:provider/callback', :to => 'session#create', :via => [:get, :post]
  get '/auth/failure', :to => 'session#failure'

  root :to => 'application#root'

end
