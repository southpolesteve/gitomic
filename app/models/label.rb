class Label < ActiveRecord::Base
  attr_accessible :color, :name

  has_many :issue_labels
  has_many :issues, :through => :issue_labels
  
end
