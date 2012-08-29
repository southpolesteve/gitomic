class Project < ActiveRecord::Base
  attr_accessible :name, :owner

  belongs_to :user
  has_many :issues, :dependent => :delete_all

  def github_issues
    user.github.issues.list_repo owner, name
  end

  def create_labels
    labels = user.github.labels(owner, name).map(&:name)
    default_labels = [
      { :name => "icebox", :color => "FFFF66" },
      { :name => "backlog", :color => "66CCFF" } 
    ]

    default_labels.each do |label|
      user.github.create_label owner, name, name: label[:name], color: label[:color]
    end
  end

  def import_issues
    result = user.github.issues owner, name
    result.each do |github_issue|
      Issue.create_from_github(github_issue)
    end
    self
  end

end
