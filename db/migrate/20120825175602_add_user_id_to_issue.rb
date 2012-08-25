class AddUserIdToIssue < ActiveRecord::Migration
  def change
    add_column :issues, :user_id, :string
    add_index :issues, :user_id
  end
end
