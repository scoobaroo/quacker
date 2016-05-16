class CreateInfoboxbuilders < ActiveRecord::Migration
  def change
    create_table :infoboxbuilders do |t|

      t.timestamps null: false
    end
  end
end
