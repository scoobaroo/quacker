class UsersController < ApplicationController

  def index
    @user = User.new
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

    params.require(:user).permit(:username, :email,:password, :current_city)

  end
end
