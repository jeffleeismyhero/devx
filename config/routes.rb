Devx::Engine.routes.draw do
  devise_for :users, class_name: "Devx::User", module: :devise

  resources :branding, controller: 'branding', only: [ :index, :update ]
  resources :articles, except: :show
  resources :venues
  resources :events
  resources :stylesheets, defaults: { format: 'css' }

  namespace :admin do
    root 'dashboard#index'
    resources :pages
    resources :menus
    resources :layouts
    resources :stylesheets
    resources :articles
    resources :calendars do
      resources :events
    end
    resources :branding
    resources :users
    resources :venues
    resources :slideshows
    resources :media
    resources :registrations do
      member do
        post 'enroll'
        get 'attendance'
        post 'attendance'
        get 'attendance_report'
      end
    end
    resources :orders do
      resources :transactions
    end
  end


  match '/:id' => 'pages#show', via: [ :get, :post ], as: :page

  root 'pages#show'
  
end
