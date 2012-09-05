class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.references :project

      t.timestamps
    end
    add_index :lists, :project_id
  end
end
