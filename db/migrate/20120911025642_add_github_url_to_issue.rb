class AddGithubUrlToIssue < ActiveRecord::Migration
  def change
    add_column :issues, :github_url, :string
  end
end
