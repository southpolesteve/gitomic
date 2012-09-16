class RemoveListIdFromLabel < ActiveRecord::Migration
  def up
    remove_column :labels, :list_id
  end

  def down
    add_column :labels, :list_id, :integer
  end
end
