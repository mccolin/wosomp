# WOSoMP
# Offering -- A one-time offering of a Sport in a given Olympiad

class Offering < ActiveRecord::Base

  # Relationships:
  belongs_to :olympiad
  belongs_to :sport
  has_many :results

  attr_accessible :olympiad_id, :sport_id, :details, :location, :begins_at, :ends_at


  def self.time_slots
    %w(10:00am 10:30am 11:00am 11:30am 12:00pm 12:30pm 1:00pm 1:30pm 2:00pm 2:30pm 3:00pm 3:30pm 4:00pm 4:30pm 5:00pm 5:30pm 6:00pm)
  end


  def name
    [sport.name, olympiad.name].join("-").gsub(/\s+/, "")
  end

end
