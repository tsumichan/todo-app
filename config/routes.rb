Rails.application.routes.draw do
  root to: 'tasks#index'
  resources :tasks, :only => [:index, :new, :create, :show, :edit, :update, :destroy]
end
