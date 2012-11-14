class AddGithubFieldsToComment < ActiveRecord::Migration
  def change
    add_column :comments, :github_created_at, :datetime
    add_column :comments, :github_updated_at, :datetime
    add_column :comments, :github_id, :integer
  end
end
