Murfhub::Application.routes.draw do
  resources :issues

  resources :projects

  root :to => "home#index"

  match "/signout" => "sessions#destroy", :as => :signout
  match "/auth/github/callback" => "sessions#create"

end
