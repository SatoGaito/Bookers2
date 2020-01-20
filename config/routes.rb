Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#top'
  get 'about' => 'home#about'
  resources :books
  resources :users, only: [:index, :show, :edit, :update]
end
