Rails.application.routes.draw do
  root to: 'tasks#index'
  resources :tasks
  get '/login',    to: 'sessions#new'
  post '/login',   to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  namespace :admin do
    resources :users, only: [:index, :new, :create, :edit, :update, :destroy] do
      resources :tasks, only: [:index], module: :users
    end
  end
end
