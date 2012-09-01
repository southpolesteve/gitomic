class Project < ActiveRecord::Base
  attr_accessible :name, :owner

  belongs_to :user
  has_many :issues, :dependent => :destroy
  has_many :labels, :dependent => :destroy

  def import
    github_labels.map(&:import)
    github_issues.map(&:import)
  end

  def ranked_icebox
    issues.icebox.rank(:icebox_priority)
  end

  def ranked_backlog
    issues.backlog.rank(:backlog_priority)
  end


  def github_labels
    user.github.labels owner, name
  end

  def github_issues
    user.github.issues owner, name
  end

end
