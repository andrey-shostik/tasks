Rails.application.routes.draw do
  root 'items#index'
  resource :user
  resource :dashboard, only: [:show]
  resources :items do
    member do
      patch :complete
    end
  end
  resource :session

  namespace :api do
    resources :users, only: [:show, :index]
    resources :items, except: [:show, :index]
  end

  get 'auth/:provider/callback', to: 'omniauth#create'
end
