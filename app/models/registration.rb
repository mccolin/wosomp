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

  # Validations:
  validates :team_id, :presence=>{:message=>"You didn't select a team to join"}
  with_options :if=>:athlete do |r|
    r.validates :uniform_size, :presence=>{:message=>"Tell us your shirt size for your uniform"}
    r.validates :uniform_name, :presence=>{:message=>"Provide a kickass name for the back of your uniform"}
    r.validates :uniform_number, :presence=>{:message=>"Select a number for your uniform"}
    r.validates :agree_waiver, :acceptance=>{:accept=>true, :message=>"You must agree to the Health and Safety waiver"}
  end
  validates :agree_pay, :acceptance=>{:accept=>true, :message=>"Please agree to pay. You can pay cash when you arrive at the event"}



  def role
    captain? ? :captain : (athlete? ? :athlete : :fan)
  end


end
