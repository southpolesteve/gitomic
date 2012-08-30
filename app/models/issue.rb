class Issue < ActiveRecord::Base
  attr_accessible :body, :closed_at, :github_created_at, 
                  :github_id, :github_updated_at, :milestone, 
                  :number, :state, :title, :user

  belongs_to :project
  belongs_to :user

  ranks :icebox_priority, :column => :priority, :with_same => :project_id, :scope => :icebox
  ranks :backlog_priority, :column => :priority, :with_same => :project_id, :scope => :backlog

  scope :icebox, where('state IS NULL OR state = ?', "icebox")
  scope :backlog, where(state: "backlog")

  validates :title, :presence => true

  delegate :owner, :name, :to => :project, :prefix => true


  def update_github(user)
    if new_record?
      Github::Issue.create(user, project_owner, project_name, github_params)
    else
      Github::Issue.update(user, project_owner, project_name, number, github_params)
    end
  end

  def github_params
    { :body => body,
      :title => title,
    }
  end

end
