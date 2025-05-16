Rails.application.routes.draw do
  # Devise routes
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    confirmations: 'users/confirmations'
  }
  
  # Root path
  root "dashboard#index"
  
  # Dashboard
  get 'dashboard', to: 'dashboard#index'

  # Cadastros
  resources :customers do
    resources :contacts, except: [:index, :show]
    resources :addresses, except: [:index, :show]
  end

  resources :equipments do
    resources :maintenance_reports
    resources :equipment_images, only: [:create, :destroy]
    resources :documents, only: [:new, :create, :destroy]
    resources :photos, only: [:new, :create, :destroy]
    resources :accessories, except: [:index, :show]
    resources :maintenances, except: [:index, :show]
    resources :schedules, except: [:index, :show]
    resources :alerts, except: [:index, :show]
    collection do
      get :available
    end
  end

  # Locações
  resources :rentals do
    member do
      patch :approve
      patch :reject
      patch :cancel
      patch :finish
    end
    resources :rental_items
    resources :documents, only: [:create, :destroy]
    resources :rental_items, path: 'itens'
    resources :rental_movements, path: 'movimentacao'
    resources :rental_billings, path: 'cobranca'
    resources :rental_maintenances, path: 'manutencao'
    resources :rental_notes, path: 'acompanhamento'
  end

  # Financeiro
  resources :invoices do
    member do
      patch :pay
      patch :cancel
    end
  end
  
  resources :payments do
    collection do
      get :pending
      get :completed
    end
  end

  # Ordens de Serviço
  resources :service_orders do
    member do
      patch :start
      patch :finish
      patch :cancel
    end
    resources :service_items
    resources :service_images, only: [:create, :destroy]
  end

  # Configurações
  namespace :settings do
    resources :users
    resources :tenants
    resources :roles
    resources :equipment_categories
    resources :service_categories
  end

  # API endpoints
  namespace :api do
    namespace :v1 do
      resources :customers, only: [:index, :show]
      resources :equipment, only: [:index, :show]
      resources :rentals, only: [:index, :show, :create]
    end
  end

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"

  resources :rental_billings
  resources :categories
  resources :accessories
  resources :people do
    member do
      get :new_commercial_reference
      get :new_bank_reference
      get :new_related_person
    end
    resources :person_documents, only: [:create, :destroy]
    resources :bank_references, only: [:create]
    resources :related_people, only: [:create]
    resources :commercial_references, only: [:new, :create, :edit, :update, :destroy]
  end
  resources :carriers
  resources :employees
  resources :works
  resources :services do
    resources :service_tax_rules, only: [:index, :new, :create, :edit, :update, :destroy]
  end
  resources :financial_natures
  resources :cost_centers
  resources :rentals
  resources :invoices
  resources :payments
  resources :service_orders
end
