Katalog::Application.routes.draw do


  resources :projects, :only => [:index, :show, :new]

  root :to => 'application#root'

end
