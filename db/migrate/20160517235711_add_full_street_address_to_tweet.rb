class AddFullStreetAddressToTweet < ActiveRecord::Migration
  def change
    add_column :tweets, :full_street_address, :string
  end
end
