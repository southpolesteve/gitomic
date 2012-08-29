Murfhub::Application.routes.draw do
  
  get "list/update"

  resources :projects do 
    resources :issues
  end

  root :to => "home#index"

  match "/signout" => "sessions#destroy", :as => :signout
  match "/auth/github/callback" => "sessions#create"

end
