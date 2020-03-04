Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :breweries, only: [:index, :create, :show]
      resources :reviews, only: [:index, :create, :show, :delete]
      get '/user' => 'users#current_user'
      get '/auth' => 'sessions#set_cookie'
      post '/login' => 'sessions#create'
      delete '/logout' => 'sessions#destroy'
      post '/signup' => 'users#create'
    end
  end
 
  get '/auth/facebook/callback', to: 'sessions#fbauth'
  get 'auth/facebook/redirect', to: 'sessions#facebook_redirect'

end
