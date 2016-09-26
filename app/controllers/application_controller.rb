class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :host_url
  helper_method :customer_act_search
  helper_method :authenticate_any

  before_action :configure_permitted_parameters, if: :devise_controller?

  def host_url
=begin    
    if Rails.env == "Production"
      @h = "http://www.research-ss.com"
    else  
      @h = "http://localhost:3000"
    end
=end
    @h = "http://www.research-ss.com/"
  end

  def customer_act_search(id, relation)
    @id = id.to_i
    @string = "properties LIKE '%\""+"#{relation}"+"\":"+"#{@id}"+"%'"
  end

  def authenticate_any!
    if admin_signed_in?
        true
    else
        authenticate_customer!
    end
end

  protected

  def configure_permitted_parameters
    if Rails.env.production?
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :submname, :route_files, :empresa, :idempresa, :email, :password, :password_confirmation, :remember_me, :current_password)}
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :submname, :route_files, :empresa, :idempresa, :email, :password, :password_confirmation, :remember_me, :current_password)}
    else
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :submname, :route_files, :empresa, :idempresa, :email, :password, :password_confirmation, :remember_me, :current_password)}
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :submname, :route_files, :empresa, :idempresa, :email, :password, :password_confirmation, :remember_me, :current_password)}
    end
  end
end
