Rails.application.routes.draw do
  root "static_pages#index"

  resources :users, only: [:index, :new, :create]
  resources :financials, except: [:new, :edit]

  namespace :users do
    get "sign_in" => "sessions#new"
    post "sign_in" => "sessions#create"
    delete "sign_out" => "sessions#delete"
  end
end
