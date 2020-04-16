Rails.application.routes.draw do
  root 'static_pages#home'
  get '/documentation', to: 'static_pages#documentation'
  get '/about', to: 'static_pages#about'
  resources :text_documents
end
