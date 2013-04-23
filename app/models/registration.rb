# WOSoMP
# Registration -- A one-time sign-up of a User/Athlete to a Team during one Olympiad

class Registration < ActiveRecord::Base

  # Relationships:
  belongs_to :user
  belongs_to :olympiad
  belongs_to :team
  has_many :results

  # Scopes:
  scope :on_team, lambda{|t| where(:team_id=>t.id) }
  scope :for_user, lambda{|u| where(:user_id=>u.id) }
  scope :for_olympiad, lambda{|o| where(:olympiad_id=>o.id) }
  scope :captains, where(:captain=>true)
  scope :athletes, where(:athlete=>true)
  scope :spectators, where(:athlete=>false)
  scope :with_uniform, where("athlete = ? OR uniform_shirt = ?", true, true)
  scope :checked_in, where(:checked_in=>true)
  scope :not_checked_in, where(:checked_in=>false)

  # Attributes:
  attr_accessible :user_id, :olympiad_id, :team_id, :captain, :uniform_name, :uniform_number, :uniform_size,
    :athlete, :paid, :agree_pay, :agree_waiver, :uniform_shirt, :checked_in,
    :points_total, :points_gold, :points_silver, :points_bronze, :count_total, :count_gold, :count_silver,
    :count_bronze


  # Validations:
  with_options :if=>:uniform_shirt do |r|
    r.validates :team_id, :presence=>{:message=>"You didn't select a team to support"}
    r.validates :uniform_size, :presence=>{:message=>"Tell us your shirt size"}
  end
  with_options :if=>:athlete do |r|
    r.validates :team_id, :presence=>{:message=>"You didn't select a team to join"}
    r.validates :uniform_size, :presence=>{:message=>"Tell us your shirt size for your uniform"}
    r.validates :uniform_name, :presence=>{:message=>"Provide a kickass name for the back of your uniform"}
    r.validates :uniform_number, :presence=>{:message=>"Select a number for your uniform"}
    r.validates :agree_waiver, :acceptance=>{:accept=>true, :message=>"You must agree to the Health and Safety waiver"}
  end
  validates :agree_pay, :acceptance=>{:accept=>true, :message=>"Please agree to pay. You can pay cash when you arrive at the event"}


  def name
    [olympiad.name, user.name].join("-").gsub(/\s+/, "")
  end

  def role
    athlete? ? (captain? ? :captain : :athlete) : :supporter
  end

  def fee
    athlete? ? 30 : (uniform_shirt? ? 20 : 10)
  end

  def check_in!
    update_attributes(checked_in: true)
  end

  def paid!
    update_attributes(paid: true)
  end


  def shirt_asset_path
    file_basename = if athlete?
      "#{team.shirt_color}_#{uniform_number}_#{uniform_name.downcase().gsub(/[^0-9a-z]/, "")}"
    else
      "#{team.shirt_color}_fan"
    end
    if Rails.application.assets.find_asset("reg/#{file_basename}.png").nil?
      "reg/wosomp.png"
    else
      "reg/#{file_basename}.png"
    end
  end


  # Update award point and count caches for this registration/athlete:
  def update_result_caches
    award_counts = Result.where(:registration_id=>id).group(:award).count()
    self.count_gold = award_counts["gold"] || 0
    self.count_silver = award_counts["silver"] || 0
    self.count_bronze = award_counts["bronze"] || 0
    self.count_total = self.count_gold + self.count_silver + self.count_bronze

    award_points = Result.where(:registration_id=>id).group(:award).sum(:points_athlete)
    self.points_gold = award_points["gold"] || 0
    self.points_silver = award_points["silver"] || 0
    self.points_bronze = award_points["bronze"] || 0
    self.points_total = self.points_gold + self.points_silver + self.points_bronze

    save()
  end

end
