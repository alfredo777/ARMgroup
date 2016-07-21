class HomeController < ApplicationController
   skip_before_filter :verify_authenticity_token 
  def index
  end

  def contact
    @mail = ContactMailer.contact_email(params[:email], "jardarubydv@gmail.com", params[:name], params[:phone], params[:comment]).deliver_now
    @mail = ContactMailer.contact_email(params[:email], "jardarubydv@gmail.com", params[:name], params[:phone], params[:comment]).deliver_now

    puts @mail
    render json: {reponse: true}
  end

  def arm
  end

  def blog_call
    @blog = Publication.paginate(:page => params[:page], :per_page => 30).order('id DESC')
  end
end
