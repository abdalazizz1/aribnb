Rails.application.routes.draw do
  get '/reservations/:id/braintree/new' => "braintree#new" , as:"new_braintree"
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "users", only: [:create , :show , :edit , :update] do

    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]

    resources :reservations, only: [:index]

  end
  resources :listings do
    resources :reservations
  end

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root  'users#index'
  get 'users/secret'
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"
  get "/listings/:id/user_listings" => "listings#user_listings" , as: "user_listings"

  post '/listings/:id/verify' => "listings#verify", as: "verify_listing"
  post '/reservations/:id/checkout' => "braintree#checkout", as: "checkout"
end
