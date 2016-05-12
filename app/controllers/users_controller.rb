class UsersController < ApplicationController

  def index
    @user = User.new
  end

  def show
    @user = User.find_by_id(params[:id])
  end

  def edit
    @user = User.find_by_id(params[:id])
  end

  def update
    @user = User.find_by_id(params[:id])
    @user.update_attributes(user_params)
    redirect_to @user
  end

  def destroy
    @user = User.find_by_id(params[:id])
    @user.destroy
  end

  def create
    @user = User.create(user_params)
    if @user.save
      login(@user)
      redirect to @user
    else
      render :index
    end
  end


  private

  def user_params

    params.require(:user).permit(:username, :email,:password_digest, :current_city)

  end
end
