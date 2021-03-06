Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :breweries, only: [:index, :create]
      resources :reviews, only: [:index, :create, :show, :delete]
      
      get '/user' => 'sessions#get_user'
      get '/auth' => 'sessions#set_token'

      # Facebook routes for later.
      get '/auth/facebook/callback', to: 'sessions#fbauth'
      get 'auth/failure', to: redirect('/')

      
      post '/login' => 'sessions#create'
      post '/brewery' => 'breweries#show'
      post '/signup' => 'users#create'

      delete '/logout' => 'sessions#destroy'

    end
  end

end
