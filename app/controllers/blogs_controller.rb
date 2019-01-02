class BlogsController < ApplicationController
  before_action :logged_in_user, only: %i[create destroy]
  before_action :correct_user, only: :destroy

  def create
    @blog = current_user.blogs.build blog_params
    if @blog.save
      flash[:success] = "blog created!"
      redirect_to root_url
    else
      @feed_items = []
      render "static_pages/home"
    end
  end

  def destroy
    @blog.destroy
    flash[:success] = "blog deleted"
    redirect_to request.referrer || root_url
  end

  private

  def blog_params
    params.require(:blog).permit :title, :content
  end

  def correct_user
    @blog = current_user.blogs.find_by id: params[:id]
    redirect_to root_url if @blog.nil?
  end
end
