Rails.application.routes.draw do
  get 'customer_files/shared', as: "customers_share_files"

  get 'customer_files/open_file', as: "open_file"

  get 'customer_files/audio_search', as: "customer_audio_files"

  get 'customer_files/audio_selected', as: "open_audio"

  get 'customer_files/notify', as: :customer_notify

  get 'admin/panel'

  get 'admin/customers', as: "admin_customers"

  get 'admin/create_customer', as: "admin_create_customer"
  post 'admin/create_customer'

  get 'admin/new_customer', as: "admin_new_customer"

  get 'admin/edit_customer', as: "admin_edit_customer"

  get 'admin/update_customer', as: "admin_update_customer"
  post 'admin/update_customer'

  get 'admin/delete_customer', as: "admin_delete_customer"
  post 'admin/delete_customer'

  get 'admin/view_all_pages', as: "admin_view_all_pages"

  get 'admin/edit_pages', as: "admin_edit_pages_op"
  post 'admin/edit_pages'

  get 'api/blog', as: "blog_call"


  get 'api/create_notify', as: "create_notify"
  post  'api/create_notify'

  get "admin/library/:id", to: "admin#library", as: "library_admin"


  get "admin/files_add/:id", to: "admin#files_add"
  post "admin/files_add/:id", to: "admin#files_add"
  get "admin/library_event", as: :library_event

  get "admin/delete_file", as: :delete_file
  post "admin/delete_file"

  get "admin/notify", as: :admin_notify

  resources :publications
  devise_for :customers, path_names: { password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'cmon_let_me_in' }, :path_prefix => 'my'
  devise_for :admins, path_names: { password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'cmon_let_me_in' }
  
  authenticate :admins do
    resources :publications, only: [:new, :create, :edit, :update, :destroy]
  end

  get 'home/index'
  get 'home/contact'
  post 'home/contact'
  get 'home/arm'
  root 'home#index'
end
