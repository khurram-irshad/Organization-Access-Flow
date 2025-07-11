Rails.application.routes.draw do
  # Devise for users with custom registrations controller
  devise_for :users, controllers: { registrations: "users/registrations" }

  # Organization and membership resources - FIXED ROUTING
  resources :organizations do
    resource :membership, only: [:create, :destroy], controller: 'organization_memberships'
  end

  # Content resources (for age-based access)
  resources :contents, only: [:index, :show]

  # Age group resources (view-only per PRD)
  resources :age_groups, only: [:index, :show]

  # Parental consent resources
  resources :parental_consents, only: [:show, :update]

  # Analytics route
  get "/analytics/organization/:organization_id", to: "analytics#organization", as: :organization_analytics

  # Root path to content index
  root "contents#index"

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check
end