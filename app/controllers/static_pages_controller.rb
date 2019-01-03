class StaticPagesController < ApplicationController
  def home
    @feed_items = Blog.all.paginate page: params[:page]
    if logged_in?
      @blog  = current_user.blogs.build
      @comment = current_user.comments.build
      @feed_items = current_user.feed.paginate page: params[:page]
    end
  end

  def help; end

  def about; end
end
