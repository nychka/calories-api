Rails.application.routes.draw do
  get 'translates/translate'

  get 'image_search/search'
  devise_for :users, controllers: { sessions: 'users/sessions' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :products
  resources :categories
end
