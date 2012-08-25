class AddGithubStateToIssue < ActiveRecord::Migration
  def change
    add_column :issues, :github_state, :string
  end
end
