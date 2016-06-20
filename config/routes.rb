Devx::Engine.routes.draw do
  devise_for :users, class_name: "Devx::User", module: :devise, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' } do
    get '/login' => 'devise/sessions#new'
  end

  resources :articles, except: :show
  resources :calendars do
    member do
      post 'subscribe' => 'calendars#subscribe'
    end

    resources :events, only: [ :show ] do
      member do
        post 'subscribe' => 'events#subscribe'
      end
    end
  end
  resources :registrations, only: [ :show, :create ]
  resources :stylesheets, only: :show, defaults: { format: 'css' }
  resources :javascripts, only: :show, defaults: { format: 'js' }

  namespace :portal do
    get '/' => 'dashboard#index', as: :dashboard
    post 'developer/update', to: 'developer#update'
    match 'developer/commerce', to: 'developer#commerce_settings', via: [ :get, :post ]
    match 'developer/sms_alert', to: 'developer#sms_alert_settings', via: [ :get, :post ]
    match 'users/import', to: 'users#import', via: [ :get, :post ]

    
    resources :pages
    resources :menus
    resources :layouts
    resources :javascripts
    resources :stylesheets
    resources :articles
    resources :calendars do
      resources :events
    end
    resources :members
    resources :alumni
    resources :faqs
    resources :products
    resources :documents
    resources :sports
    resources :extracurriculars
    resources :urgent_news
    resources :branding
    resources :users do
      member do
        match 'account-deposit', to: 'users#account_deposit', via: [ :get, :post ]
      end
    end
    resources :roles
    resources :venues
    resources :slideshows
    resources :media
    resources :administration
    resources :registrations do
      resources :forms
      member do
        post 'enroll'
        get 'attendance'
        post 'attendance'
        get 'attendance_report'
      end
    end
    resources :orders, except: [ :edit ] do
      resources :transactions
    end
    resources :tickets
    resources :developer, only: :index
    
    root 'dashboard#index'
  end

  get '/search' => 'pages#search'
  match '/:id' => 'pages#show', via: [ :get, :post ], as: :page

  root 'pages#show'
  
end
