class AddListIdToLabel < ActiveRecord::Migration
  def change
    add_column :labels, :list_id, :integer
  end
end
