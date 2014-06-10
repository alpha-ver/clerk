Rails.application.routes.draw do
  get  'page/index'
  root 'page#index'
  get  'dashboard'           => 'dashboard#index'
  get  'dashboard/:id'       => 'dashboard#index'

  resources  :templates
  devise_for :users

  #get 'products/:id' => 'catalog#view'
end
