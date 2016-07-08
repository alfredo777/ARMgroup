class ApiController < ApplicationController
  def blog
    posts = Publication.paginate(:page => params[:page], :per_page => 35).order('id DESC')

    render json: {posts: posts}
  end
end
