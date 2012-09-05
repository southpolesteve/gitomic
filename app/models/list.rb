class List < ActiveRecord::Base
  belongs_to :project
  has_many :issues
  has_one :label
  
end
