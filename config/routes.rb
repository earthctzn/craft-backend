Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :breweries only: [:index, :create]
      resources :reviews
    end
  end

  
  post 'api/v1/login' => 'sessions#login'
  post 'api/v1/logout' => 'sessions#logout'
  post 'api/v1/signup' => 'users#create'
  

  get '/auth/facebook/callback', to: 'sessions#fbauth'
  get 'auth/failure', to: redirect('http://localhost:5000/login')

end
