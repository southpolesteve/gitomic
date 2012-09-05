class AddListToLabel < ActiveRecord::Migration
  def change
    add_column :labels, :list, :boolean
  end
end
