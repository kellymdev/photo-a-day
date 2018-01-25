Rails.application.routes.draw do
  root 'pages#index'

  get 'home', to: 'pages#index', as: 'home_path'

  resources :categories
  resources :subjects
end
