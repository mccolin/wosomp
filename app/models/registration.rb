# WOSoMP
# Registration -- A one-time sign-up of a User/Athlete to a Team during one Olympiad

class Registration < ActiveRecord::Base

  # Relationships:
  belongs_to :user
  belongs_to :olympiad
  belongs_to :team

  # Scopes:
  scope :on_team, lambda{|t| where(:team_id=>t.id) }
  scope :for_user, lambda{|u| where(:user_id=>u.id) }
  scope :for_olympiad, lambda{|o| where(:olympiad_id=>o.id) }
  scope :captains, where(:captain=>true)
  scope :athletes, where(:athlete=>true)
  scope :spectators, where(:athlete=>false)

  # Attributes:
  attr_accessible :user_id, :olympiad_id, :team_id, :captain, :uniform_name, :uniform_number, :uniform_size
  attr_accessible :athlete, :paid, :agree_pay, :agree_waiver


  def role
    captain? ? :captain : (athlete? ? :athlete : :fan)
  end


end
