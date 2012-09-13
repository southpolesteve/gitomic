class IssueLabel < ActiveRecord::Base
  belongs_to :label
  belongs_to :issue
  
  attr_accessible :label_id
  
end
