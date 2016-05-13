class AddTweetToComment < ActiveRecord::Migration
  def change
    add_reference :comments, :tweet, index: true, foreign_key: true
  end
end
