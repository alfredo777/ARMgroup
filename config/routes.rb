Rails.application.routes.draw do
  get 'customer_files/shared'

  get 'customer_files/audio_search'

  get 'customer_files/audio_selected'

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

  resources :publications
  devise_for :customers, path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'cmon_let_me_in' }, :path_prefix => 'my'
  devise_for :admins, path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'cmon_let_me_in' }
  
  authenticate :admins do
    resources :publications, only: [:new, :create, :edit, :update, :destroy]
  end

  get 'home/index'
  get 'home/contact'
  post 'home/contact'
  get 'home/arm'
  root 'home#index'
end
