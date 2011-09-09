class AdminUser < ActiveRecord::Base

  enable_as_typus_user

  # 
  # ROLE = Typus::Configuration.roles.keys.sort
  # LOCALE = Typus.locales
  # 
  # enable_as_typus_user

end
