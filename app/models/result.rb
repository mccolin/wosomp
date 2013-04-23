# WOSOMP
# Result -- The result of a match or tournament for a player/team in a sport

class Result < ActiveRecord::Base

  # Relationships:
  belongs_to :offering
  belongs_to :registration
  belongs_to :team

  # Scopes:
  scope :players, where("registration_id IS NOT NULL")
  scope :teams, where(:registration_id=>nil)

  # Attributes:
  attr_accessible :award, :points_athlete, :points_team, :note, :offering_id, :registration_id, :team_id

  # What results are possible?
  def self.result_types
    Result.award_types + %w(participant none)
  end

  # What award types are possible?
  def self.award_types
    %w(gold silver bronze)
  end


  def name
    name_parts = [offering.name, team.name]
    name_parts << registration.user.name if registration
    name_parts.join("-").gsub(/\s+/, "")
  end

  # Is this result for an entire team?
  def team_result?
    registration_id.nil?
  end

  # Is this result for a single player?
  def athlete_result?
    !team_result?
  end

  # Return a list of results earning the same result:
  def partner_results
    r = Result.where(:offering_id=>offering_id, :award=>award)
  end




  protected

  def update_point_values
    self.points_athlete = offering.sport.points_for_athlete(self.award)
    self.points_team = offering.sport.points_for_team(self.award)
  end
  before_save :update_point_values

  def update_team_caches
    self.team.update_result_caches() if self.team
  end
  after_save :update_team_caches

  def update_registration_caches
    self.registration.update_result_caches() if self.registration
  end
  after_save :update_registration_caches



end
