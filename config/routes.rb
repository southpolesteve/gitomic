Gitomic::Application.routes.draw do
  
  mount Resque::Server, :at => "/resque"

  resources :issue_labels
  resources :labels
  resources :projects do 
    resources :issues
    resources :labels do
      member do
        post 'make_list'
      end
    end
    collection do
      get 'import'
    end
    member do
      get 'settings'
    end
  end

  root :to => "home#index"

  match "/signout" => "sessions#destroy", :as => :signout
  match "/auth/github/callback" => "sessions#create"

end
