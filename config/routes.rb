Rails.application.routes.draw do
  resources :meals
  devise_for :users, controllers: {sessions: 'sessions'}
  get 'translates/translate'
  get 'image_search/search'
  resources :products, constraints: { id: /\d+/}
  resources :categories
  get '/products/my', to: 'products#my'
end
