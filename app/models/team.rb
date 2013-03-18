# WOSOMP
# Team -- A single team, which exists for a single Olympiad

class Team < ActiveRecord::Base

  # Relationships:
  belongs_to :olympiad
  has_many :registrations
  has_many :users, :through=>:registrations

  attr_accessible :olympiad_id, :name, :color1, :color2, :color1_code, :color2_code, :bio

end
