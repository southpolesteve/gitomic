class Comment < ActiveRecord::Base
  belongs_to :issue
  belongs_to :user
  
  validates :body, :user_id, :presence => true
  
end
