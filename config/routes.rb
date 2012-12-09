Gitomic::Application.routes.draw do

  mount Resque::Server, :at => "/resque"

  resources :issue_labels
  resources :labels
  resources :projects do
    resources :issues do
      resources :comments
    end
    resources :labels do
    end
    collection do
      get 'import'
    end
    member do
      get 'settings'
    end
  end

  resources :users do
    member do
      get 'invite'
    end
  end

  resources :webhooks

  root :to => "home#index"

  match "/signout" => "sessions#destroy", :as => :signout
  match "/auth/github/callback" => "sessions#create"

end
