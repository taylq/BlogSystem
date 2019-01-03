class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
    :following, :followers]
    
  def show
    @user = User.find_by id: params[:id]
    @blogs = @user.blogs.paginate page: params[:page], per_page: 5
    @comment = current_user.comments.build if logged_in?
    if current_user == @user
      @blog  = current_user.blogs.build
      @feed_items = @user.feed.paginate page: params[:page], per_page: 5
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t ".welcome"
      redirect_to @user
    else
      render "new"
    end
  end

  def following
    @title = t ".following"
    @user  = User.find_by id: params[:id]
    @users = @user.following.paginate page: params[:page], per_page: 5
    render "show_follow"
  end

  def followers
    @title = t ".followers"
    @user  = User.find_by id: params[:id]
    @users = @user.followers.paginate page: params[:page], per_page: 5
    render "show_follow"
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end
end
