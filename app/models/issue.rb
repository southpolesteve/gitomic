class Issue < ActiveRecord::Base
  include RankedModel

  attr_accessible :body, :closed_at, :github_created_at, 
                  :github_id, :github_updated_at, :milestone, 
                  :number, :state, :title, :user, :icebox_priority_position, 
                  :backlog_priority_position

  belongs_to :project
  belongs_to :user
  belongs_to :list, :class_name => :label

  has_many :issue_labels, :dependent => :destroy
  has_many :labels, :through => :issue_labels

  ranks :icebox_priority, :column => :priority, :with_same => :project_id, :scope => :icebox
  ranks :backlog_priority, :column => :priority, :with_same => :project_id, :scope => :backlog

  scope :icebox, where('state IS NULL OR state = ?', "icebox")
  scope :backlog, where(state: "backlog")

  validates :title, :presence => true

  delegate :owner, :name, :to => :project, :prefix => true


  def update_github(user)
    if github_params_changed?
      if new_record?
        Github::Issue.create(user, project_owner, project_name, github_params)
      else
        Github::Issue.update(user, project_owner, project_name, number, github_params)
      end
    end
  end

  def github_params_changed?
    github_params.each do |k,v|
      return true if self.send("#{k}_changed?")
    end
    false
  end

  def github_params
    { :body => body,
      :title => title,
    }
  end

end
