class HomeController < ApplicationController
   skip_before_filter :verify_authenticity_token 
   layout "legal", only: [:legal_terms_and_conditions, :privacy]
  def index
  end

  def contact
    @mail = ContactMailer.contact_email(params[:email], "alfredo@rockstars.mx", params[:name], params[:phone], params[:comment]).deliver_now
    @mail = ContactMailer.contact_email(params[:email], "carolina.cortes@research-ss.com", params[:name], params[:phone], params[:comment]).deliver_now
    @mail = ContactMailer.contact_email(params[:email], "contacto@research-ss.com", params[:name], params[:phone], params[:comment]).deliver_now

    puts @mail
    render json: {reponse: true}
  end

  def arm
  end

  def legal_terms_and_conditions
  end

  def privacy
  end

  def blog_call
    @blog = Publication.paginate(:page => params[:page], :per_page => 30).order('id DESC')
  end
end
