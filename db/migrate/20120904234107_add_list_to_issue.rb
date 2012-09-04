class AddListToIssue < ActiveRecord::Migration
  def change
    add_column :issues, :list_id, :integer
    add_index :issues, :list_id
  end
end
