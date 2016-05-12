class AddLatitudeToTweet < ActiveRecord::Migration
  def change
    add_column :tweets, :latitude, :float
  end
end
