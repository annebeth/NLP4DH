Rails.application.routes.draw do
  root 'text_documents#index'
  get '/documentation', to: 'static_pages#documentation'
  get '/about', to: 'static_pages#about'
  resources :text_documents
end
