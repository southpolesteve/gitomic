class Issue < ActiveRecord::Base
  include RankedModel

  attr_accessible :body, :closed_at, :github_created_at, 
                  :github_id, :github_updated_at, :milestone, 
                  :number, :state, :title, :user, :priority_position,
                  :assignee_id, :issue_labels_attributes, :list_id

  belongs_to :project
  belongs_to :user
  belongs_to :list, :class_name => 'Label'
  belongs_to :assignee, :class_name => 'User'

  has_many :issue_labels, :dependent => :destroy
  has_many :labels, :through => :issue_labels, :uniq => true

  accepts_nested_attributes_for :issue_labels, :allow_destroy => true

  ranks :priority, :with_same => [:project_id, :list_id]

  scope :not_on_list, where(:list_id => nil)

  validates :title, :presence => true

  delegate :owner, :name, :to => :project, :prefix => true


  def update_github(user)
    if true
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
      :assignee => assignee.try(:github_login),
      :labels => labels.map(&:name),
    }
  end

  # def move_to_list(list)
  #   self.labels << list unless self.labels.include?(list)
  #   self.list = list
  # end

end
