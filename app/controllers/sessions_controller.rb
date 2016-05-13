class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    user_params = params.require(:user).permit(:username, :password)
    @user = User.confirm(user_params)
    if @user
      login(@user)
      flash[:success] = "Successfully logged in."
      puts "login!"
      redirect_to @user
    else
      redirect_to login_path
      puts "logout!"
    end
  end

  def destroy
    logout
    redirect_to root_path
  end

end
