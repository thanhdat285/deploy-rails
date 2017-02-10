Rails.application.routes.draw do
  root "static_pages#index"

  resources :users, only: [:index, :new, :create]
end
