Rails.application.routes.draw do
  get  'page/index'
  root 'page#index'
  get  'dashboard'                                    => 'dashboard#index'
  get  'dashboard/category/:category_id'              => 'dashboard#document'
  get  'dashboard/generate/:template_id/:document_id' => 'dashboard#generate'


  post 'dashboard/template' => 'dashboard#template'

  resources  :templates
  devise_for :users

  #get 'products/:id' => 'catalog#view'
end
