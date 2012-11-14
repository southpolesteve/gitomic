class Issue < ActiveRecord::Base
  include RankedModel

  attr_accessible :body, :closed_at, :github_created_at, 
                  :github_id, :github_updated_at, :milestone, 
                  :number, :state, :title, :user, :priority_position,
                  :assignee_id, :issue_labels_attributes, :list_id,
                  :label_ids

  belongs_to :project
  belongs_to :user
  belongs_to :list, :class_name => 'Label'
  belongs_to :assignee, :class_name => 'User'

  has_many :issue_labels, :dependent => :destroy
  has_many :labels, :through => :issue_labels, :uniq => true
  has_many :comments, :dependent => :destroy

  accepts_nested_attributes_for :issue_labels, :allow_destroy => true

  ranks :priority, :with_same => [:project_id, :list_id]

  scope :not_on_list, where(:list_id => nil)

  validates :title, :presence => true

  delegate :owner, :name, :to => :project, :prefix => true

  def find_github_issue(user)
    Github::Issue.find user, project_owner, project_name, number
  end

  def update_github_issue(user)
    if valid?
      @github_issue = Github::Issue.update(user, project_owner, project_name, number, github_params)
      save_github_response
    end
  end

  def create_github_issue(user)
    if valid?
      @github_issue = Github::Issue.create(user, project_owner, project_name, github_params)
      save_github_response
    end
  end

  def github_params_changed?
    [:body, :title, :assignee_id, :labels].each do |field|
      return true if self.send("#{field}_changed?")
    end
    false
  end

  def github_params
    { :body => body,
      :title => title,
      :assignee => assignee.try(:github_login),
      :labels => labels.map(&:name),
    }
  end

  private

  def save_github_response
    self.github_created_at = @github_issue.created_at
    self.github_id = @github_issue.id
    self.github_updated_at = @github_issue.updated_at
    self.number = @github_issue.number
    self.github_state = @github_issue.state
    self.github_url = @github_issue.url
    save
  end


end
