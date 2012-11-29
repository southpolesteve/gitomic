class RemoveLists < ActiveRecord::Migration
  def up
    remove_column :labels, :list
    remove_column :issues, :list_id
    drop_table :lists
  end

  def down
  end
end
