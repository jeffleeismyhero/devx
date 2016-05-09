Devx::Engine.routes.draw do
  devise_for :users, class_name: "Devx::User", module: :devise

  resources :branding, controller: 'branding', only: [ :index, :update ]
  resources :articles, except: :show
  resources :venues
  resources :events

  namespace :admin do
    root 'dashboard#index'
    resources :pages
    resources :articles
    resources :events
    resources :branding
    resources :users
    resources :venues
    resources :slideshows
    resources :media
    resources :orders do
      resources :transactions
    end
  end


  match '/:id' => 'pages#show', via: [ :get, :post ], as: :page

  root 'pages#show'
  
end
