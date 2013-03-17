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

  # Major Fields:
  attr_accessible :name, :description, :field, :equipment, :rules, :num_per_team, :num_teams, :tournament_style, :image
  attr_accessible :olympiad_ids


  def style
    num_per_team > 1 ? :team : :individual
  end

end
