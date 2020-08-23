Rails.application.routes.draw do
  root to: 'projects#index'

  get '/register', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :projects
  resources :tickets do
    resources :comments, except: [:index, :show, :new]
  end
  resources :tags
  resources :users, only: [:create, :edit, :update]
end
