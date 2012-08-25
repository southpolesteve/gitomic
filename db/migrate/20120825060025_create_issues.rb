class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.string :state
      t.datetime :closed_at
      t.string :milestone
      t.integer :number
      t.text :body
      t.string :title
      t.datetime :github_created_at
      t.datetime :github_updated_at
      t.integer :github_id
      t.integer :project_id

      t.timestamps
    end
    
    add_index :issues, :project_id
  end
end
