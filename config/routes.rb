Katalog::Application.routes.draw do


  resources :projects, :only => [:index, :show, :new] do
    resources :posts, :only => [:create]
  end

  root :to => 'application#root'

end
