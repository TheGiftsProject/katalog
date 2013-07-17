Katalog::Application.routes.draw do

  root 'root#index'

  resources :katas, :only => [:index, :show]

end
