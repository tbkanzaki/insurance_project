Rails.application.routes.draw do
  root "home#index"

  devise_for :users, controllers: {
		registrations: 'users/registrations',
		sessions: 'users/sessions',
		omniauth_callbacks: 'users/omniauth_callbacks'
		}

  resources :policies, only: %i(index new create)
  get 'search', to: 'policies#search'

  get 'payments/success'
  get 'payments/cancel'

  mount ActionCable.server => '/cable'
  post "/transmits_police_payment_status", to: "payments#transmits_police_payment_status"

  get 'error', to: 'home#error'

  get "up" => "rails/health#show", as: :rails_health_check
end
