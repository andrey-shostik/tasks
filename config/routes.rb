Rails.application.routes.draw do
  root 'dashboards#show'

  resource :session
  resource :dashboard, only: [:show]

  resources :users do
    resource :profile, except: [:destroy]
  end

  resources :items, except: [:index] do
    member do
      patch :complete
    end
  end

  namespace :api do
    resource :session
    resource :dashboard, only: [:show]

    resources :users, except: [:edit, :new] do
      resource :profile, except: [:destroy, :edit, :new]
    end

    resources :items, except: [:edit, :new]
  end

  get 'auth/:provider/callback', to: 'omniauth#create'
  get 'api/auth/:provider/callback', to: 'api/omniauth#create'
end
