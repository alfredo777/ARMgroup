class ApiController < ApplicationController
  def blog
    posts = Publication.paginate(:page => params[:page], :per_page => 35).order('id DESC')

    render json: {posts: posts}
  end


  def create_notify 
    notify = Notice.new
    notify.customer_id = params[:customer_id]
    notify.admin_id = params[:admin_id]
    notify.content = params[:content]
    notify.owner_id = params[:owner_id]
    notify.owner_type = params[:owner_type]
    notify.save

    redirect_to :back
  end

  def create_action
    action = Action.new
    action.action = params[:act]
    action.time_in_come = "#{Time.now}"
    action.customer_id = current_customer.id
    action.save
  end
end
