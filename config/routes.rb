Rails.application.routes.draw do
  devise_for :vendors, controllers: {
    registrations: 'registrations',
    omniauth_callbacks: 'omniauth_callbacks'
  }

  get 'connect_to_stripe', to: 'vendor_onboarding#connect_to_stripe'
  get 'stripe_connect_confirmation', to: 'vendor_onboarding#stripe_connect_confirmation'

  resources :invoices
  root 'home#index'
end
