Rails.application.routes.draw do
  root 'static_pages#home'
  get '/documentation', to: 'static_pages#documentation'
  get '/about', to: 'static_pages#about'
  get '/text_documents/:id/analyze', to: 'text_documents#analyze', as: "analyze_text_document"
  resources :text_documents
end
