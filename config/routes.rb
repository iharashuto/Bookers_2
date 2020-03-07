Rails.application.routes.draw do
  devise_for :users
  resources :users
  resources :books
  resources :favorites, only: [:create, :destroy]
  root 'books#top'
  get "home/about" => "books#about"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
