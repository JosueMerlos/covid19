Rails.application.routes.draw do
  get 'countries/index'
  post 'countries/index'
  root 'countries#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
