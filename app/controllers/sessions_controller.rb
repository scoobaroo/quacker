class SessionsController < ApplicationController

  def new
    @user = User.new
    render :new
  end

  def create
    user_params = params.require(:user).permit(:username, :password)
    @user = User.confirm(user_params)
    if @user
      login(@user)
      flash[:success] = "Successfully logged in."
      redirect_to user_path
    else
      redirect_to login_path
    end

    def destroy
      logout
      redirect_to root_path
    end
  end

  private
  #
  # def user_params
  #
  #   params.require(:user).permit(:username, :password)
  #
  # end
end
