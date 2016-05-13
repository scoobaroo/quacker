class UsersController < ApplicationController
  before_action :logged_in?, only: [:edit, :destroy]

  def index
    @user = User.new
  end

  def show
    @user = User.find_by_id(params[:id])
    render :show
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


  private

  def user_params

    params.require(:user).permit(:username, :email,:password, :current_city)

  end
end
