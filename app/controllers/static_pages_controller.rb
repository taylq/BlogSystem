class StaticPagesController < ApplicationController
  
  def home
    @feed_items = Blog.all.paginate page: params[:page], per_page: 5
    if logged_in?
      @blog  = current_user.blogs.build
      @comment = current_user.comments.build
      @feed_items = current_user.feed.paginate page: params[:page], per_page: 5
    end
  end

  def help; end

  def about; end
end
