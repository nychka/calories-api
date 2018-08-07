Rails.application.routes.draw do
  devise_for :users, controllers: {sessions: 'sessions'}
  get 'translates/translate'
  get 'image_search/search'
  resources :products
  resources :categories
end
