Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :breweries, only: [:index, :create, :show]
      resources :reviews, only: [:index, :create, :show, :delete]
      post '/login' => 'sessions#create'
      delete '/logout' => 'sessions#destroy'
      post '/signup' => 'users#create'
      get '/cookiefy' => 'sessions#set_cookie'
      
    end
  end
 
  get '/auth/facebook/callback', to: 'sessions#fbauth'
  get 'auth/facebook/redirect', to: 'sessions#facebook_redirect'

end
