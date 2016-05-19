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
    @user = User.friendly.find(params[:id])
    if @user != nil
      @tweets = @user.tweets.paginate(:page => params[:page], per_page: 2)
      @following = @user.following.paginate(:page => params[:page], per_page: 2)
    else
      redirect_to root_path
      flash[:notice] = "User Not Found"
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.following << @user
      login(@user)
      flash[:notice]="Account Succesfully Created!"
      redirect_to @user
    else
      flash[:notice]=@user.errors.full_messages
      redirect_to '/'
    end
  end

  def edit
    @user = User.friendly.find(params[:id])
    unless current_user.id == @user.id
      flash[:notice] = "You may not edit other user accounts"
      redirect_to "/"
    end
  end

  def update
    @user = User.friendly.find(params[:id])
    unless user_params != nil
      Cloudinary::Uploader.upload(user_params)
    end
    if current_user.id == @user.id
      @user.update_attributes(user_params)
      flash[:notice] = "Profile updated."
      redirect_to @user
    else
      flash[:notice] = @user.errors.full_messages
      redirect_to user_path
    end
  end

  def destroy
    @user = User.friendly.find(params[:id])
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
    @user  = User.friendly.find(params[:id])
    @followers = @user.followers
    @users = @user.following
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.friendly.find(params[:id])
    @followers = @user.followers
    render 'show_followers'
  end

  private

  def user_params
    params.require(:user).permit(:username, :email,:password, :current_city, :avatar)
  end

end
