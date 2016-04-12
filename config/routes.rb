Rails.application.routes.draw do
  root 'items#index'
  resource :user
  resource :welcome, only: [:show]
  resources :items do
    member do
      patch :complete
    end
  end
  resource :session

  namespace :api do
    resources :users, except: [:edit, :new]
    resources :items, except: [:edit, :new]
  end
end
