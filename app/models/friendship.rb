class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, :class_name => 'User'
  
  validate :validate_unique_by_user_id_and_friend_id
  after_create :create_notification
  
  private
  
    def validate_unique_by_user_id_and_friend_id
      self.errors[:base] << "You already have this user as a friend" if Friendship.exists?(:user_id => self.user_id, :friend_id => self.friend_id)
    end
    
    # Create notifications to the users friends
    def create_notification
      notification = Notification.new(:body =>I18n.translate('notification.types.new_follower') )
      notification.user_id = self.friend_id
      notification.save
    end
end