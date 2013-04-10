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
  attr_accessible :award, :award_value_player, :award_value_team, :group_name, :match_number, :match_round, :match_score, :offering_id, :registration_id, :team_id, :type


  # Is this result for an entire team?
  def team?
    registration_id.nil?
  end

  # Is this result for a single player?
  def player?
    !team?
  end

  # Return results for the same match amongst teammates
  def partner_results
    r = Result.where(:offering_id=>offering_id, :match_round=>match_round, :match_number=>match_number)
    r = r.where(:group_name=>group_name) if group_name                # Same group
    r = r.where("registration_id != ?", registration_id) if player?   # Not same person
    r = r.where(:team_id=>team_id) if team?                           # Same team (needed?)
    return r
  end

  # Return results for the same match amongst opponents
  def opponent_results
    r = Result.where(:offering_id=>offering_id, :match_round=>match_round, :match_number=>match_number)
    r = r.where("group_name != ?", group_name) if group_name
    r = r.where("registration_id != ?", registration_id) if player?
    r = r.where("team_id != ?", team_id) if team?
    return r
  end


end
