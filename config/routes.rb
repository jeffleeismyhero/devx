Devx::Engine.routes.draw do

  get '/not-found', to: 'pages#not_found'

  devise_for :users, class_name: "Devx::User", module: :devise,
    controllers: { omniauth_callbacks: 'devx/omniauth_callbacks' },
    path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }

  constraints  subdomain: 'portal'  do
    scope module: 'portal', as: 'portal' do

    authenticated :user, -> user { user.super_administrator? } do
      match 'jobs', to: DelayedJobWeb, anchor: false, via: [ :get, :post ]
    end

    get '/cart' => 'cart#index'
    get '/cart/empty' => 'cart#empty'
    get '/cart/:id' => 'cart#add'
    
    get '/' => 'dashboard#index', as: :dashboard
    get '/terms-of-service', to: 'dashboard#terms_of_service'
    get '/privacy-policy', to: 'dashboard#privacy_policy'
    get '/donate', to: 'donations#donate'
    get 'profile', to: 'users#show', as: :profile
    match 'account-balance', to: 'users#account_balance', via: [ :get, :post ], as: :account_balance
    post 'developer/update', to: 'developer#update'
    match 'developer/commerce', to: 'developer#commerce_settings', via: [ :get, :post ]
    match 'developer/sms_alert', to: 'developer#sms_alert_settings', via: [ :get, :post ]

    ## Import paths
    match 'users/import', to: 'users#import', via: [ :get, :post ]
    match 'users/import-linked', to: 'users#import_linked_users', via: [ :get, :post ]
    match 'articles/import', to: 'articles#import', via: [ :get, :post ]
    match 'calendars/:id/import', to: 'calendars#import', via: [ :get, :post ], as: :calendar_import
    match 'administration/import', to: 'administration#import', via: [ :get, :post ]
    match 'transactions/import', to: 'account_transactions#import', via: [ :get, :post ]

    resources :account_transactions, path: 'transactions', only: [ :index ] do
      member do
        post 'process_transaction'
      end
    end
    post 'transactions/process-all', to: 'account_transactions#process_all'

    resources :pages
    resources :menus do
      collection { post :sort }
    end
    resources :layouts
    resources :javascripts, except: :show
    resources :stylesheets, except: :show
    resources :articles
    resources :calendars do
      resources :events
    end
    resources :alumni
    resources :classrooms do
      resources :class_schedules
      resources :class_galleries do
        resources :class_photos
      end
      resources :class_highlights
      resources :class_announcements
      resources :class_documents
    end
    resources :announcements
    resources :donations
    resources :faqs
    resources :products
    resources :documents
    resources :sports
    resources :extracurriculars
    resources :urgent_news
    resources :branding
    resources :users do
      member do
        patch 'reset-password', to: 'users#reset_password'
        match 'account-deposit', to: 'users#account_deposit', via: [ :get, :post ]
      end
    end
    resources :roles
    resources :venues
    resources :forms do
      member do
        get 'submissions'
      end
    end
    resources :slideshows
    resources :media
    resources :administration
    resources :registrations do
      resources :forms
      resources :registration_submissions, path: 'submissions', only: :show
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
  end

  ## Public-facing
  resources :articles, path: 'news', only: [ :index, :show ] do
    member do
      post 'subscribe' => 'articles#subscribe'
    end
  end

  resources :calendars, path: 'calendar', only: [ :index ] do
    member do
      get 'export-all', to: 'calendars#export_all'
      post 'subscribe', to: 'calendars#subscribe'
    end

    resources :events, only: [ :show ] do
      resources :schedules, only: [ :show ]
      member do
        post 'subscribe' => 'events#subscribe'
      end
    end
  end

  get '/branding.css', to: 'stylesheets#branding'
  get '/directory', to: 'administration#index'
  match '/calendar', to: 'calendars#show', via: [ :get, :post ]
  match '/contact', to: 'contact#show', via: [ :get, :post ]

  resources :registrations, only: [ :show, :create ]
  resources :forms, only: [ :show, :create ]
  resources :stylesheets, only: :show, defaults: { format: 'css' }
  resources :javascripts, only: :show, defaults: { format: 'js' }



  get '/search' => 'pages#search'
  match '/:id' => 'pages#show', via: [ :get, :post ], as: :page

  root 'pages#show'

end
