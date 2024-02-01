Rails.application.routes.draw do
  resources :urls
  get 'home/index'
  # devise_for :users
  devise_for :users, controllers: {
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get "/:short", to: "api/v1/urls#redirect"

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      post "/shorten", to: "urls#shorten"
        
      resource :sessions, only: [:create, :destroy]
    end
  end

  # Defines the root path route ("/")
  root "home#index"
end
