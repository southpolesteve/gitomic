class Project < ActiveRecord::Base
  attr_accessible :name, :owner, :org

  belongs_to :creator, :class_name => 'User', :foreign_key => 'user_id'

  has_many :issues, :dependent => :destroy
  has_many :labels, :dependent => :destroy
  has_many :lists, :dependent => :destroy
  has_many :project_memberships, :dependent => :destroy
  has_many :users, :through => :project_memberships, :uniq => true

  def import_labels
    github_labels.map(&:import)
  end

  def import_issues
    github_issues.map(&:import)
  end

  def github_labels
    creator.github.labels owner, name
  end

  def github_issues
    creator.github.issues owner, name
  end

  def github_collaborators
    creator.github.collaborators owner, name
  end

  def github_org_members
    creator.github.org_members name
  end

  def import_team
    github_team.each{ |github_user| github_user.import(owner, name) }
  end

  def github_team
    org ? github_org_members : github_collaborators
  end

end
