Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    sessions: "auth/sessions"
  }
  resources :movies, only: [:index, :show, :create, :update, :destroy]
  resources :categories, only: [:index, :show, :create, :update, :destroy]
  resources :users, only: [:index, :show, :create, :update, :destroy]
  post 'import_movies', to: 'api_movies#import'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
