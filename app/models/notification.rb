class Notification < ActiveRecord::Base
  attr_accessible :body
  
  validates :body, :presence => true, :length => { :maximum => 100 }
  validates :user_id, :presence => true
  
  belongs_to :user
  
  def read!
    self.read = true
    self.save
  end
end