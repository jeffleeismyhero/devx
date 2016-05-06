Devx::Engine.routes.draw do
  devise_for :users, class_name: "Devx::User", module: :devise

  resources :branding, controller: 'branding', only: [ :index, :update ]
  resources :articles, except: :show
  resources :venues
  resources :events
  resources :users

  namespace :admin do
    resources :pages
    resources :articles
    resources :events
    resources :branding
    resources :users
    resources :venues
    resources :orders do
      resources :transactions
    end
  end


  match '/:id' => 'pages#show', via: [ :get, :post ]

  root 'pages#show'
  
end
