Rails.application.routes.draw do
  resources :movies, only: :index
  resources :categories, only: :index
  resources :users, only: :index
  resources :users, only: [:index, :show, :create, :destroy, :update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
