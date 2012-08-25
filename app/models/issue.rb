class Issue < ActiveRecord::Base
  attr_accessible :body, :closed_at, :github_created_at, :github_id, :github_updated_at, :milestone, :number, :state, :title

  belongs_to :project

end
