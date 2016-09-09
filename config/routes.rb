Rails.application.routes.draw do
  get 'customer_files/shared', as: "customers_share_files"

  get 'customer_files/open_file', as: "open_file"

  get 'customer_files/audio_search', as: "customer_audio_files"

  get 'customer_files/audio_selected', as: "open_audio"

  get 'customer_files/notify', as: :customer_notify

  get "customer_files/zip_compress_download", as: :zip_compress_download
  post "customer_files/zip_compress_download"

  get 'customer_files/create_backup',as: :create_backup
  post 'customer_files/create_backup'

  get 'customer_files/view_backups', as: :view_backups
  
  get 'customer_files/delete_backup', as: :delete_backup

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

  get 'admin/campaings', as: "campaings_user_list_admin"

  get 'admin/create_campaing', as: :create_campaing
  post 'admin/create_campaing'

  get 'admin/delete_campaing', as: :delete_campaing
  post 'admin/delete_campaing'

  get '/audio_search_files', to: "customer_files#audio_search_files",as: "audio_search_files"
  post '/audio_search_files', to: "customer_files#audio_search_files"

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

  get "legal/terms_and_conditions", to: "home#legal_terms_and_conditions", as: :legal_terms_and_conditions
  get "legal/privacy", to: "home#privacy", as: :legal_privacity
  get "legal/aviso_de_privacidad",  to: 'home#aviso_de_privacidad', as: :aviso_de_privacidad

  resources :publications
  devise_for :customers, path_names: {sign_out: 'sign_out', password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'cmon_let_me_in' }, :path_prefix => 'my'
  devise_for :admins  do #path_names: {sign_out: 'sign_out', password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'cmon_let_me_in' }
  get '/admins/sign_out' => 'devise/sessions#destroy'
  end



  authenticate :admins do
    resources :publications, only: [:new, :create, :edit, :update, :destroy]
  end

  get 'home/index'
  get 'home/contact'
  post 'home/contact'
  get 'home/arm'
  root 'home#index'
end
