Rails.application.routes.draw do

  root :to => 'welcome#index'

  get '/signin' => 'sessions#new'
  post '/signin' => 'sessions#create'
  post '/logout' => 'sessions#destroy'

  resources :categories
  resources :comments
  resources :purchased_items
  resources :items do 
    resources :comments
  end
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
