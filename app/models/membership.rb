# WOSoMP
# Membership -- A one-time membership of a User/Athlete to a Team during one Olympiad

class Membership < ActiveRecord::Base

  # Relationships:
  belongs_to :user
  belongs_to :team

  attr_accessible :user_id, :team_id, :captain, :uniform_name, :uniform_number, :uniform_size
  
end
