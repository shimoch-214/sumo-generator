Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  get '/about', to: 'home#index'

  resources :home, only: :index

  namespace :api, format: 'json' do
    resources :calcs, only: [:index, :create]
  end
end
