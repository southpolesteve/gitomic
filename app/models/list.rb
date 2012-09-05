class List < ActiveRecord::Base
  belongs_to :project
  has_many :issues
  has_one :label

  accepts_nested_attributes_for :label

  attr_accessible :label
  
end
