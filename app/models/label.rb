class Label < ActiveRecord::Base
  attr_accessible :color, :name

  has_many :issue_labels, :dependent => :destroy
  has_many :issues, :through => :issue_labels
  has_many :list_issues, :class_name => "Issue"

end
