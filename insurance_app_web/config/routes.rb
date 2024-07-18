Rails.application.routes.draw do
  root "home#index"

  devise_for :users, controllers: {
		registrations: 'users/registrations',
		sessions: 'users/sessions',
		omniauth_callbacks: 'users/omniauth_callbacks'
		}

  get "up" => "rails/health#show", as: :rails_health_check

  resources :policies, only: %i(index new create)

  get 'search', to: 'policies#search'
  get 'policies/success', to: 'policies#success'
  get 'policies/cancel', to: 'policies#cancel'
  get 'error', to: 'home#error'
end
