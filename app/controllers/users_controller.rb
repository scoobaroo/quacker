class UsersController < ApplicationController
  before_action :logged_in?, only: [:edit, :destroy]

  def index
    if params[:search]
      @users = User.search(params[:search])
    else
      @users= User.all.order(created_at: :desc)
    end

    if current_user
      @following = current_user.following
    else
      render :index
    end
  end

  def show
    @user = User.find_by_id(params[:id])
    if @user != nil
      @tweets = @user.tweets.paginate(:page => params[:page], per_page: 10)
      @following = @user.following
    else
      redirect_to root_path
      flash[:notice] = "user not found"
    end
  end

  def create
    
  end

  def edit
    @user = User.find_by_id(params[:id])
    unless current_user.id == @user.id
      flash[:notice] = "You may not edit other user accounts"
      redirect_to "/"
    end
  end

  def update
    @user = User.find_by_id(params[:id])
    Cloudinary::Uploader.upload(params[:user][:avatar])

    if current_user.id == @user.id
      @user.update_attributes(user_params)
      flash[:notice] = "Profile updated."
      redirect_to @user
    else
      flash[:notice] = "What do you think you are doing? Do you think this is a game?"
      redirect_to user_path
    end
  end

  def destroy
    @user = User.find_by_id(params[:id])
    if current_user.id == @user.id
    @user.destroy
    redirect_to "/"
    else
      flash[:notice] = "What do you think you are doing? Do you think this is a game?"
      redirect_to user_path
    end
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @followers = @user.followers
    @users = @user.following
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers
    render 'show_follow'
  end

  private

  def user_params
    params.require(:user).permit(:username, :email,:password, :current_city, :avatar)
  end

end
