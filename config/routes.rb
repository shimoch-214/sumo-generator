Rails.application.routes.draw do

  devise_for :users
  namespace :api, defaults: {format: 'json'} do
    mount_devise_token_auth_for 'User', at: 'auth', controllers: {
      registrations: 'api/auth/registrations',
    }
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  resources :home, only: :index
  namespace :api, format: 'json' do
    resources :samples, only: :show
    post 'calcs/calculate'
  end

  get '*unmatched_route', to: 'home#index'
end
