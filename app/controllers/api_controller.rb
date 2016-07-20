class ApiController < ApplicationController
  def blog
    posts = Publication.paginate(:page => params[:page], :per_page => 35).order('id DESC')

    render json: {posts: posts}
  end

  def create_action
    action = Action.new
    action.action = params[:act]
    action.time_in_come = "#{Time.now}"
    action.customer_id = current_customer.id
    action.save
  end
end
