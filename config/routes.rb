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
end
