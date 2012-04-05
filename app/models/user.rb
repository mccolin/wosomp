# WOSOMP
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :first_name, :last_name, :password, :password_confirmation, :remember_me
  
  # Quick combined accessors:
  def name; "#{first_name} #{last_name}"; end
  
  
  
  # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
  class << self

    def find_for_facebook_oauth(auth_data, signed_in_resource=nil)
      data = auth_data.extra.raw_info
      logger.debug ("AUTH DATA: #{data.inspect}")
      if user = User.where(:email=>data.email).first
        user
      else
        User.create!(
          :email=>data.email, 
          :first_name=>data.first_name, 
          :last_name=>data.last_name, 
          :password=>Devise.friendly_token[0,20]
        )
      end      
    end
  
  end # self
  # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
  
end
