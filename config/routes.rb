Rails.application.routes.draw do

  root :to => 'welcome#index'

  get '/signin' => 'sessions#new'
  post '/signin' => 'sessions#create'
  post '/logout' => 'sessions#destroy'

  get '/auth/facebook/callback' => 'sessions#create'
  get '/auth/:github/callback' => 'sessions#create'
  get 'auth/failure' => redirect('/')

  post '/item/:id/purchase' => 'items#purchase'
  
  resources :categories
  resources :comments
  resources :items do 
    resources :comments, only: [:new]
  end
  resources :users do 
    resources :comments, only: [:edit]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
