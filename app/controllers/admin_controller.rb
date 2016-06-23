class AdminController < ApplicationController
  before_action :authenticate_admin!
  layout "intern"
  def panel
  end

  def customers
  end

  def create_customer
  end

  def edit_customer
  end

  def delete_customer
  end

  def view_all_pages
  end
end
