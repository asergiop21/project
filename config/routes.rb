Rails.application.routes.draw do

  resources :update_process_articles

  scope ':locale', locale: /#{I18n.available_locales.join("|")}/ do

    get 'stock' => 'reports#minimum_stock', as: :stock
    resources :accounting_records
    get 'daile_report' => 'accounting_records#daily_report', as: :daily_report

    resources :categories
    resources :customers do 
      get 'find/:id' => 'customers#find', as: :store, :on =>  :collection
      resources :current_accounts
    end

    resources :invoice_stocks
    resources :stocks
    resources :brands
    resources :orders
    resources :invoices do
      get :autocomplete_customer_name, :on => :collection
    end
    resources :suppliers
    get :event_for_blocks, to: 'articles#event_for_blocks'
    post :update_article_blocks, to: 'articles#update_article_blocks'
    resources :articles do
      get 'find' => 'articles#find', as: :due_date, :on => :collection
      get :autocomplete_supplier_name, :on => :collection

    end
    devise_for :users
    resources :users

  end 

  authenticated :user do 
    root :to => 'articles#index'
  end
  unauthenticated :user do
    devise_scope :user do
      get "/" => "devise/sessions#new"
    end
  end
end
