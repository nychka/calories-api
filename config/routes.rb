Rails.application.routes.draw do
  resources :meals, except: [:destroy]
  delete '/meals', to: 'meals#destroy'
  devise_for :users, controllers: {sessions: 'sessions'}
  get 'translates/translate'
  get 'image_search/search'
  resources :products, constraints: { id: /\d+/}
  resources :categories
end
