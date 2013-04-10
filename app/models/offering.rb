# WOSoMP
# Offering -- A one-time offering of a Sport in a given Olympiad

class Offering < ActiveRecord::Base

  # Relationships:
  belongs_to :olympiad
  belongs_to :sport
  has_many :results

  attr_accessible :olympiad_id, :sport_id, :details

  # does_keys :column=>:details
  # has_key :location
  # has_key :schedule

end
