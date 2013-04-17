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
    %w(gold silver bronze participant none)
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

  def update_award_values
    points_athlete = offering.sport.points_for_athlete(award)
    points_team = offering.sport.points_for_team(award)
  end
  before_save :update_award_values

  def update_team_caches
    puts "Updating team caches..."
    if team?
      # Update team.count_gold/silver/bronze (medal matching award)
      # Update team.points_gold/silver/bronze (medal matching award)
      # Update team.count_total
      # Update team.points_total
      #team.update_attributes()
    end
  end
  after_save :update_team_caches

  def update_registration_caches
    puts "Updating registration caches..."
    if registration?
      # Update registration.count_gold/silver/bronze (medal matching award)
      # Update registration.points_gold/silver/bronze (medal matching award)
      # Update registration.count_total
      # Update registration.points_total
      #registration.update_attributes()
    end
  end
  after_save :update_registration_caches



end
