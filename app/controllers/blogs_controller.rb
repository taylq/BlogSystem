class BlogsController < ApplicationController
  before_action :correct_user, only: :destroy

  def create
    @blog = current_user.blogs.build blog_params
    if @blog.save
      flash[:success] = t ".blog_created"
      redirect_to request.referrer || root_url
    else
      @feed_items = []
      render "static_pages/home"
    end
  end

  def destroy
    @blog.destroy
    flash[:danger] = t ".blog_deleted"
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
