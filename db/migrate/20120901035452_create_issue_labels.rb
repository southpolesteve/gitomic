class CreateIssueLabels < ActiveRecord::Migration
  def change
    create_table :issue_labels do |t|
      t.references :label
      t.references :issue

      t.timestamps
    end
    add_index :issue_labels, :label_id
    add_index :issue_labels, :issue_id
  end
end
