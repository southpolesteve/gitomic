class Project < ActiveRecord::Base
  attr_accessible :name, :owner, :org

  belongs_to :user

  has_many :issues, :dependent => :destroy
  has_many :labels, :dependent => :destroy
  has_many :lists, :dependent => :destroy

  def import_labels
    github_labels.map(&:import)
  end

  def import_issues
    github_issues.map(&:import)
  end

  def github_labels
    user.github.labels owner, name
  end

  def github_issues
    user.github.issues owner, name
  end

  def github_collaborators
    user.github.collaborators owner, name
  end

  def github_org_members
    user.github.org_members name
  end

  def github_team
    org ? github_org_members : github_collaborators
  end

end
