Devx::Engine.routes.draw do
<<<<<<< HEAD
  namespace :portal do
  get 'javascripts/index'
  end

  namespace :portal do
  get 'javascripts/edit'
  end

  namespace :portal do
  get 'javascripts/new'
  end

  get 'javascripts/show'

  namespace :portal do
  get 'javascript/index'
  end

  namespace :portal do
  get 'javascript/edit'
  end

  namespace :portal do
  get 'javascript/new'
  end

  namespace :portal do
  get 'product/index'
  end

  namespace :portal do
  get 'product/show'
  end

  namespace :portal do
  get 'product/new'
  end

  namespace :portal do
  get 'product/edit'
  end

  namespace :portal do
  get 'product/create'
  end

  namespace :portal do
  get 'product/update'
  end

  namespace :portal do
  get 'product/destroy'
  end

  namespace :portal do
  get 'product/event_params'
  end

  get 'product/index'

  get 'product/show'

  get 'product/new'

  get 'product/edit'

  get 'product/create'

  get 'product/update'

  get 'product/destroy'

  get 'product/event_params'

  namespace :portal do
  get 'extracurriculars/index'
  end

  namespace :portal do
  get 'extracurriculars/new'
  end

  namespace :portal do
  get 'extracurriculars/edit'
  end

  namespace :portal do
  get 'extracurriculars/show'
  end

  namespace :portal do
  get 'extracurriculars/create'
  end

  namespace :portal do
  get 'extracurriculars/update'
  end

  namespace :portal do
  get 'extracurriculars/destroy'
  end

  namespace :portal do
  get 'extracurriculars/extracurricular_params'
  end

  namespace :portal do
  get 'sports/index'
  end

  namespace :portal do
  get 'sports/new'
  end

  namespace :portal do
  get 'sports/edit'
  end

  namespace :portal do
  get 'sports/create'
  end

  namespace :portal do
  get 'sports/update'
  end

  namespace :portal do
  get 'sports/destroy'
  end

  namespace :portal do
  get 'sports/sport_params'
  end

  get 'sports/index'

  get 'sports/new'

  get 'sports/edit'

  get 'sports/create'

  get 'sports/update'

  get 'sports/destroy'

  get 'sports/sport_params'

  namespace :portal do
  get 'faqs/index'
  end

  namespace :portal do
  get 'faqs/new'
  end

  namespace :portal do
  get 'faqs/edit'
  end

  namespace :portal do
  get 'faqs/create'
  end

  namespace :portal do
  get 'faqs/update'
  end

  namespace :portal do
  get 'faqs/destroy'
  end

  namespace :portal do
  get 'faqs/faq_params'
  end

  namespace :portal do
  get 'urgent_news/index'
  end

  namespace :portal do
  get 'urgent_news/new'
  end

  namespace :portal do
  get 'urgent_news/edit'
  end

  namespace :portal do
  get 'urgent_news/show'
  end

  namespace :portal do
  get 'urgent_news/create'
  end

  namespace :portal do
  get 'urgent_news/update'
  end

  namespace :portal do
  get 'urgent_news/destroy'
  end

  namespace :portal do
  get 'urgent_news/urgent_news_params'
  end

  get 'urgent_news/index'

  get 'urgent_news/new'

  get 'urgent_news/edit'

  get 'urgent_news/show'

  get 'urgent_news/create'

  get 'urgent_news/update'

  get 'urgent_news/destroy'

  get 'urgent_news/urgent_news_params'

  get 'urgent_news/show'

  get 'urgentnews/show'

  get 'javascript/show'
=======
>>>>>>> origin/master

  devise_for :users, class_name: "Devx::User", module: :devise, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' } do
    get '/login' => 'devise/sessions#new'
  end

  resources :branding, controller: 'branding', only: [ :index, :update ]
  resources :articles, except: :show
  resources :events
  resource :stylesheets, defaults: { format: 'css' }
  resource :javascripts, defaults: { format: 'js' }

  namespace :portal do
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
    resources :alumni
    resources :branding
    resources :users
    resources :roles
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
