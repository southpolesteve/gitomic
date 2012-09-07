Gitomic::Application.routes.draw do
  

  resources :issue_labels

  resources :labels

  resources :projects do 
    resources :issues
    resources :labels do
      member do
        post 'create_list'
      end
    end
    resources :lists
  end

  root :to => "home#index"

  match "/signout" => "sessions#destroy", :as => :signout
  match "/auth/github/callback" => "sessions#create"

end
