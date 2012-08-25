class AddAvatarUrlAndGithubTokenToUser < ActiveRecord::Migration
  def change
    add_column :users, :avatar, :string
    add_column :users, :github_token, :string
  end
end
