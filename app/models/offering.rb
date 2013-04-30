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

  def display_begins_at
    return nil unless begins_at
    begins_at.strftime("%-I:%M%P")
  end

  def display_ends_at
    return nil unless ends_at
    ends_at.strftime("%-I:%M%P")
  end

  def past?
    return false unless begins_at && ends_at
    end_time = ends_at.hour.to_f + ends_at.min / 60.0
    now_time = Time.zone.now.hour.to_f + Time.zone.now.min / 60.0
    end_time < now_time
  end

  def present?
    return false unless begins_at && ends_at
    beg_time = begins_at.hour.to_f + begins_at.min / 60.0
    end_time = ends_at.hour.to_f + ends_at.min / 60.0
    now_time = Time.zone.now.hour.to_f + Time.zone.now.min / 60.0
    beg_time < now_time && end_time > now_time
  end

  def future?
    !past? && !present?
  end

end
