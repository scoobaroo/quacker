class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  @tweets = Tweet.all
  @hash = Gmaps4rails.build_markers(@tweets) do |tweet, marker|
    marker.lat tweet.latitude
    marker.lng tweet.longitude
  end
  
end
