Rails.application.routes.draw do
  resources :templates

  devise_for :users

  # root 'welcome#index'

  #   get 'products/:id' => 'catalog#view'
  resources :dashboard

  
end
