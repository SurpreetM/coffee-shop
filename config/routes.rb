Rails.application.routes.draw do

  root :to => 'welcome#index'
  
  resources :categories
  resources :comments
  resources :purchased_items
  resources :items
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
