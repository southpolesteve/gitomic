class Project < ActiveRecord::Base
  attr_accessible :name, :owner

  belongs_to :user
  has_many :issues, :dependent => :delete_all
  has_many :labels, :dependant => :delete_all

  def setup_github_labels
    labels = user.github.labels(owner, name).map(&:name)

    default_labels.each do |label|
      user.github.create_label owner, name, name: label[:name], color: label[:color]
    end
  end

  def import_github_issues
    github_issues = user.github.issues owner, name
    github_issues.each do |github_issue|
      github_issue.import
    end
    self
  end

  def ranked_icebox
    issues.icebox.rank(:icebox_priority)
  end

  def ranked_backlog
    issues.backlog.rank(:backlog_priority)
  end

  private

  def default_labels
    [
      { :name => "icebox", :color => "FFFF66" },
      { :name => "backlog", :color => "66CCFF" } 
    ]
  end

end
