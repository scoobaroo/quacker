class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  @tweets = Tweet.all
  @hash = Gmaps4rails.build_markers(@tweets) do |tweet, marker|
    marker.lat tweet.latitude
    marker.lng tweet.longitude
    marker.infowindow  "<b>#{tweet.body}#{tweet.title}</b>"
    marker.picture({
                  :url => "http://www.fancyicons.com/free-icons/219/ree/png/256/yellow_ducky_256.png",
                  :width   => 32,
                  :height  => 32
                 })
    marker.title   "#{tweet.title}"
    marker.json({ :id => tweet.id })
  end
end
