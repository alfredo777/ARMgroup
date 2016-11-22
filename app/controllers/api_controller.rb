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
    
    notice = "<h3>Usted ha recibido una notificación ingrese a ARM para responderla | <a href='#{host_url}/customer_files/notify'>Ingresar</a> </h3>"
   
    if params[:owner_type] == "Admin"
       toemail = Customer.find(params[:customer_id])
       toemail = toemail.email
       fromemail = "contacto@research-ss.com"
       #toemail = "alfredo@rockstars.mx"
       @mail = ContactMailer.notify_me(fromemail,toemail,notice).deliver_now
    else
      puts "Notificación de administrador"
    end


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
