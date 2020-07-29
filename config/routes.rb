Rails.application.routes.draw do
  get 'l/:id' => 'links#show'
  resources :members, only: [:new, :create, :show, :index]

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  get 'welcome', to: 'sessions#welcome'
  post 'friendships', to: 'friendships#create'

  root to: 'sessions#welcome'
end
