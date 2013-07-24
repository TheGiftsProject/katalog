Katalog::Application.routes.draw do


  resources :projects, :only => [:index, :show]

  root :to => 'application#root'

end
