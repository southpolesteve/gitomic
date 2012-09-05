class AddLabelsImportedAtAndIssuesImportedAtToProject < ActiveRecord::Migration
  def change
    rename_column :projects, :imported_at, :labels_imported_at
    add_column :projects, :issues_imported_at, :datetime
  end
end
