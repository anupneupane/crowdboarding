class City < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true, :length => { :maximum => 100 }
  
  before_create :downcase_name
  belongs_to :country
  
  private
    def downcase_name
      self.name.downcase!
    end
end