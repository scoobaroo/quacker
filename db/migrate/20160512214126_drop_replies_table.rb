class DropRepliesTable < ActiveRecord::Migration
  def up
    drop_table :replies
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
