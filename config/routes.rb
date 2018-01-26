Rails.application.routes.draw do
  root 'categories#index'

  get 'home', to: 'pages#index', as: 'home_path'

  resources :categories
  resources :subjects, except: [:index] do
    resources :photos, except: [:index]
  end
end
