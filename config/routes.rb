Rails.application.routes.draw do
  get  'page/index'
  root 'page#index'
  get  'dashboard'                                    => 'dashboard#index'
  get  'dashboard/category/:category_id'              => 'dashboard#document'
  get  'dashboard/generate/:document_id/:template_id' => 'dashboard#generate'

  resources  :templates, :except => [:index, :new, :show]
  resources  :fields,    :except => [:index, :new, :show]
  resources  :documents,  :except => []
  
  scope '/admin' do 
    resources  :users,      :except => [:new, :create, :show]
    resources  :categories, :except => [:index, :show]
  end

  devise_for :users



  ####
  ####
  ####
  post "test" => 'dashboard#test'
  #get 'products/:id' => 'catalog#view'
end
