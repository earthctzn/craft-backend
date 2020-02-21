Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :breweries, only: [:index, :create, :show]
      resources :reviews, only: [:create, :show, :delete]
      resources :users, only: [:create]
    end
  end

 
  post 'api/v1/login' => 'sessions#create'
  post 'api/v1/logout' => 'sessions#logout'
  post 'api/v1/signup' => 'users#create'
  
 
  get '/auth/facebook/callback', to: 'sessions#fbauth'
  get 'auth/failure', to: 'sessions#facebook_redirect'

end
