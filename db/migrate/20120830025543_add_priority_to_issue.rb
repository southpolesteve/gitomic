class AddPriorityToIssue < ActiveRecord::Migration
  def change
    add_column :issues, :priority, :integer
  end
end
