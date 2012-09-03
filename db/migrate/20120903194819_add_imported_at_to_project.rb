class AddImportedAtToProject < ActiveRecord::Migration
  def change
    add_column :projects, :imported_at, :datetime
  end
end
