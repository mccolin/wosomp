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

  # A simple env var check route (dev only):
  get "/env" => "home#testenv" if Rails.env.development?

  # Root Activities:
  get "/about" => "home#about",       :as=>"about"
  get "/terms" => "home#terms",       :as=>"terms"

  # Live Event Display:
  get "/live" => "live#index",        :as=>"live"
  get "/live/:id" => "live#index",    :as=>"live_specific"

  # Olympiads, Registration, etc.
  resources :olympiads, :only=>[:index, :show] do
    resources :teams, :only=>[:index, :show, :update] do
      member do
        post :save_post         # Write on a Team Wall
        delete :delete_post     # Remove a Wall Post
      end
    end
    resources :sports, :only=>[:show] do
    end
    member do
      get :events               # Events Listing
      get :location             # Location details, directions
      get :register             # Register for event
      get :registration         # View/Edit registration
      post :save_registration   # Save/Update registration
      delete :unregister        # Cancel registration for event
    end
  end

end
