Rails.application.routes.draw do
  devise_for :users, controllers: {sessions: 'sessions'}

  resources :products, constraints: { id: /\d+/}, only: [:index, :create]
  delete '/products', to: 'products#destroy'

  resources :categories

  resources :meals, only: [:index, :create]
  delete '/meals', to: 'meals#destroy'

  get 'translates/translate'
  get 'image_search/search'
end
