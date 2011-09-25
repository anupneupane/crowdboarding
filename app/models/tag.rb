class Tag < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, :use => :slugged
  
  before_create :downcase_name
  
  private
    def downcase_name
      self.name.try(:downcase)
    end
end