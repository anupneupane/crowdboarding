class City < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true, :length => { :maximum => 100 }
  
  before_create :downcase_name
  belongs_to :country

  def capitalize_name
    self.name.split(' ').each{|word| word.capitalize}.join(' ')
  end
  
  private
    def downcase_name
      self.name.downcase!
    end
end