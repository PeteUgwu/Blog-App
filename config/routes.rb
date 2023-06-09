Rails.application.routes.draw do
  devise_for :users

# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html  
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create, :destroy] do
      resources :comments, only: [:new, :create, :destroy]
      resources :likes, only: [:create]
    end
  end 
  
  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :show, :create] do
        resources :posts, only: [:index, :show, :create] do
          resources :comments, only: [:index, :show, :create]
        end
      end
    end
  end
   # Defines the root path route ("/")
  root "users#index"
end
