Rails.application.routes.draw do
  devise_for :users

  root 'home#index'
  get '/setup' => 'home#setup', as: 'setup'
  get '/academy' => 'home#academy', as: 'academy'
  get '/registrations' => 'home#registrations', as: 'registrations'

  resources :batches
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
