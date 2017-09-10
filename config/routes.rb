Rails.application.routes.draw do
  devise_for :vendors, controllers: {
    registrations: 'registrations',
    omniauth_callbacks: 'omniauth_callbacks'
  }

  get 'connect_to_stripe', to: 'vendor_onboarding#connect_to_stripe'
  root 'home#index'
end
