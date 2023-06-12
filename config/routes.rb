Rails.application.routes.draw do

  devise_scope :user do
    authenticated :user do
      root to: 'posts#index', as: :authenticated_root
    end
  
    unauthenticated :user do
      root to: 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  devise_for :users

  post '/friendship/create/:id', to: 'friendships#create'

  resources :users do
    get :log_out
  end
  resources :friendships

  resources :posts, :only => [:create, :destroy, :index] do
    resources :likes, module: :posts
    resources :comments, :only => [:create, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
