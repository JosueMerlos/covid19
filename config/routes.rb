Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :countries, only: [:index, :show]
    end
  end
  get 'countries/index'
  post 'countries/index'
  root 'countries#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
