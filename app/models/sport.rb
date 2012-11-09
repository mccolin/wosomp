# WOSOMP
# Sport -- Long-term definition of a playable sport/event

class Sport < ActiveRecord::Base

  # Relationships:
  has_many :offerings
  has_many :olympiads, :through=>:offerings

  # Major Fields:
  attr_accessible :name, :description, :field, :equipment, :rules

  # Descriptive Properties:
  does_keys :column=>:details
  has_key :players_per_team, :type=>:integer, :default=>2
  has_key :teams_per_match, :type=>:integer, :default=>2
  # etc...

end
