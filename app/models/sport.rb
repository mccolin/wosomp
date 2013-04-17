# WOSOMP
# Sport -- Long-term definition of a playable sport/event

class Sport < ActiveRecord::Base

  # Relationships:
  has_many :offerings
  has_many :olympiads, :through=>:offerings

  # Scopes:
  scope :team_sports, where("sports.num_per_team > ?", 1)
  scope :individual_sports, where(:num_per_team => 1)
  scope :bracket, where(:tournament_style => "bracket")
  scope :ranked, where(:tournament_style => "ranked")
  scope :team_bracket, where(:tournament_style => "team")

  # Major Fields:
  attr_accessible :name, :description, :field, :equipment, :rules, :num_per_team, :num_teams, :tournament_style, :image
  attr_accessible :olympiad_ids


  def style
    num_per_team > 1 ? :team : :individual
  end


  def points_for_athlete(award)
    puts "Checking points for athlete for award:#{award}"
    return 0 if tournament_style == "team"
    {gold: 15, silver: 10, bronze: 5, participant: 0, none: 0}[award.to_sym]
  end

  def points_for_team(award)
    puts "Checking points for team for award:#{award}"
    if tournament_style == "team"
      # Team-only sports
      {gold: 15, silver: 10, bronze: 5, participant: 0, none: 0}[award.to_sym]
    elsif style == :team
      # Small-team/Group sports:
      {gold: 3, silver: 2, bronze: 1, participant: 0, none: 0}[award.to_sym]
    elsif style == :individual
      # Individual/Solo sports:
      {gold: 9, silver: 6, bronze: 3, participant: 0, none: 0}[award.to_sym]
    end
  end


end
