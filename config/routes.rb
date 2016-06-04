Devx::Engine.routes.draw do
  devise_for :users, class_name: "Devx::User", module: :devise

  resources :branding, controller: 'branding', only: [ :index, :update ]
  resources :articles, except: :show
  resources :venues
  resources :events
  resources :stylesheets, defaults: { format: 'css' }

  namespace :admin do
    get '/' => 'dashboard#index', as: :dashboard
    resources :pages
    resources :menus
    resources :layouts
    resources :stylesheets
    resources :articles
    resources :calendars do
      resources :events
    end
    resources :members
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
    root 'dashboard#index'
  end


  match '/:id' => 'pages#show', via: [ :get, :post ], as: :page

  root 'pages#show'
  
end
