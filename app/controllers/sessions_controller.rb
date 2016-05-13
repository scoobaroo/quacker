class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    user_params = params.require(:user).permit(:username, :password)
    @user = User.confirm(user_params)
    if @user
      login(@user)
      flash[:notice] = "Successfully logged in."
      puts "login!"
      redirect_to @user
    else
      flash[:notice] = "Failed to log in. Please check your username/password."
      redirect_to login_path
      puts "Login failed!"
    end
  end

  def destroy
    logout
    redirect_to root_path
  end

end
