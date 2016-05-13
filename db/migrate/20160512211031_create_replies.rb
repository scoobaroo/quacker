class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.string :body

      t.timestamps null: false
    end
  end
end
