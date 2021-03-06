# WOSOMP
#

class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :facebook_id, :first_name, :last_name, :password, :password_confirmation, :remember_me,
                  :gender, :address_street, :address_city, :address_state, :address_zip, :birthday, :bio

  # Relationships:
  has_many :registrations
  has_many :olympiads, :through=>:registrations
  has_many :teams, :through=>:registrations

  # Scopes:
  scope :admin, where(:admin=>true)

  # Validations:
  validates :first_name, :presence=>{:message=>"Tell us your first name"}
  validates :last_name, :presence=>{:message=>"Tell us your last name"}
  validates :email, :presence=>{:message=>"You must provide an email address"}


  # Quick combined accessors:
  def name; [first_name, last_name].join(" "); end
  def photo_url; "http://graph.facebook.com/#{facebook_id}/picture"; end
  def address
    addr = [address_street, address_city, address_state].compact.join(", ")+(address_zip ? address_zip : "")
    addr.blank? ? "Not Provided" : addr
  end
  def male?; gender.try(:downcase) == "male"; end
  def female?; gender.try(:downcase) == "female"; end


  def registered_for?(olympiad)
    !registration_for(olympiad).nil?
  end

  def registration_for(olympiad)
    Registration.for_user(self).for_olympiad(olympiad).first
  end

  # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
  class << self

    def find_for_facebook_oauth(auth_data, signed_in_resource=nil)
      data = auth_data.extra.raw_info
      logger.debug "AUTH DATA:"
      logger.ap data
      if user = User.where(:email=>data.email).first
        user.update_attributes(
          :facebook_id=>data.id,
          :first_name=>data.first_name,
          :last_name=>data.last_name
        )
        user
      else
        User.create!(
          :email=>data.email,
          :facebook_id=>data.id,
          :first_name=>data.first_name,
          :last_name=>data.last_name,
          :password=>Devise.friendly_token[0,20]
        )
      end
    end

  end # self
  # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

end
