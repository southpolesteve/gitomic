class AddOrgToProject < ActiveRecord::Migration
  def change
    add_column :projects, :org, :boolean
  end
end
