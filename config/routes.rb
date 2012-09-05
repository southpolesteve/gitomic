Murfhub::Application.routes.draw do
  

  resources :issue_labels

  resources :labels

  resources :projects do 
    resources :issues
    resources :labels
  end

  root :to => "home#index"

  match "/signout" => "sessions#destroy", :as => :signout
  match "/auth/github/callback" => "sessions#create"

end
