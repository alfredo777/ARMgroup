Rails.application.routes.draw do
  get 'admin/panel'

  get 'admin/customers'

  get 'admin/create_customer'

  get 'admin/edit_customer'

  get 'admin/delete_customer'

  get 'admin/view_all_pages'

  resources :publications
  devise_for :customers
  devise_for :admins
  get 'home/index'
  get 'home/contact'
  post 'home/contact'
  get 'home/arm'
  root 'home#index'
end
