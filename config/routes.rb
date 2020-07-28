Rails.application.routes.draw do
  get 'l/:id' => 'links#show'
  resources :members, only: [:new, :create, :show, :index]

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'welcome', to: 'sessions#welcome'

  root to: 'sessions#welcome'
end
