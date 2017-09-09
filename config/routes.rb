Rails.application.routes.draw do
  get 'home/index'

  devise_for :vendors
  root "home#index"
end
