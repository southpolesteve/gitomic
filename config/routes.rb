Gitomic::Application.routes.draw do
  

  resources :issue_labels

  resources :labels

  resources :projects do 
    resources :issues
    resources :lists
    resources :labels do
      member do
        post 'create_list'
      end
    end

    collection do
      get 'import'
    end
  end

  root :to => "home#index"

  match "/signout" => "sessions#destroy", :as => :signout
  match "/auth/github/callback" => "sessions#create"

end
