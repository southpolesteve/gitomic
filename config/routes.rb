Murfhub::Application.routes.draw do
  root :to => "home#index"

  match "/signout" => "sessions#destroy", :as => :signout
  match "/auth/github/callback" => "sessions#create"

end
