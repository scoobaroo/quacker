class HomepageController < ApplicationController
  def index
    @user = User.new
  end

  def about_us
    render :about_us
  end
end
