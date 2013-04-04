# WOSOMP
# Routes Table

Wosomp::Application.routes.draw do

  ActiveAdmin.routes(self)

  # Authentication for Users:
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # devise_scope :users do
  #   get "login", :to=>"devise/sessions#new"
  #   delete "logout", :to=>"devise/sessions#destroy"
  # end

  # Our Application Root:
  root :to=>"home#index",             :as=>"home"

  # Root Activities:
  get "/about" => "home#about",       :as=>"about"
  get "/terms" => "home#terms",       :as=>"terms"

  # Live Event Display:
  get "/live" => "live#index",        :as=>"live"

  # resources :users

  resources :olympiads do
    resources :teams
    member do
      get :events               # Events Listing
      get :location             # Location details, directions
      get :register             # Register for event
      get :registration         # View/Edit registration
      post :save_registration   # Save/Update registration
      delete :unregister        # Cancel registration for event
      post :save_team           # Save/Update Team Details
      post :save_team_post      # Write on a Team Wall
    end
  end

end
