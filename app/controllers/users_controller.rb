class UsersController < ApplicationController
  before_action :logged_in?, only: [:edit, :destroy]

  def index
    @user = User.new
    @users= User.all

    render :index
  end

  def show
    @user = User.find_by_id(params[:id])

    if @user == nil
      redirect_to root_path
      flash[:notice] = "user not found"
    end
  end

  def edit
    @user = User.find_by_id(params[:id])
  end

  def update
    @user = User.find_by_id(params[:id])
    if current_user.id == @user.id
      @user.update_attributes(user_params)
      redirect_to @user
    else
      flash[:notice] = "What do you think you are doing? Do you think this is a game?"
      redirect_to user_path
    end
  end

  def destroy
    @user = User.find_by_id(params[:id])
    @user.destroy
    redirect_to "/"
  end

  def create
    @user = User.create(user_params)
    if @user.save
      login(@user)
      redirect_to @user
    else
      render :index
    end
  end

  # Follows a user.
  def follow(other_user)
    active_relationships.create(followed_id: other_user.id)
  end

  # Unfollows a user.
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.include?(other_user)
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

  def search
    @users = User.search(params[:search])
  end

  private

  def user_params

    params.require(:user).permit(:username, :email,:password, :current_city)

  end
end
