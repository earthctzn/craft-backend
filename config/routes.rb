Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :breweries, only: [:index, :create]
      resources :reviews, only: [:index, :create, :show, :delete]
      
      get '/user' => 'users#current_user'
      get '/auth' => 'sessions#set_cookie'

      post '/login' => 'sessions#create'
      post '/brewery' => 'breweries#show'
      post '/signup' => 'users#create'

      delete '/logout' => 'sessions#destroy'
      
    end
  end
 
  get '/auth/facebook/callback', to: 'sessions#fbauth'
  get 'auth/facebook/redirect', to: 'sessions#facebook_redirect'

end
