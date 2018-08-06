Rails.application.routes.draw do
  devise_for :users
  get 'translates/translate'
  get 'image_search/search'
  resources :products
  resources :categories
end
