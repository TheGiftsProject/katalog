Katalog::Application.routes.draw do

  root 'root#index'

  resources :projects, :only => [:index, :show, :new]

end
