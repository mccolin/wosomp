# WOSOMP
# Olympiad -- A single olympics

class Olympiad < ActiveRecord::Base

  # Relationships:
  has_many :offerings
  has_many :sports, :through=>:offerings

  # Default Sorting, etc:
  default_scope order("begins_at ASC")

  # Scopes:
  scope :live, where("begins_at < ? AND ends_at > ?", DateTime.now, DateTime.now)
  scope :registration_open, where("registration_begins_at < ? AND registration_ends_at > ?", DateTime.now, DateTime.now)
  scope :planning_open, where("planning_begins_at < ? AND planning_ends_at > ?", DateTime.now, DateTime.now)

  # Slugging temporarily disabled:
  is_sluggable :name, :slug_column=>:slug


  def is_live?
    return false if begins_at.nil? || ends_at.nil?
    begins_at < DateTime.now && ends_at > DateTime.now
  end

  def is_registering?
    return false if registration_begins_at.nil? || registration_ends_at.nil?
    registration_begins_at < DateTime.now && registration_ends_at > DateTime.now
  end

  def is_planning?
    return false if planning_begins_at.nil? || planning_ends_at.nil?
    planning_begins_at < DateTime.now && planning_ends_at > DateTime.now
  end

  def is_past?
    return false if ends_at.nil?
    ends_at < DateTime.now
  end

  def city_state
    n = [location_city, location_state].compact.join(", ")
  end

  def city_state_zip
    n = [location_city, location_state, location_zip].compact.join(", ")
  end

  def mappable_address
    "#{location_address}, #{city_state_zip}".gsub(/\s/,"+")
  end

  # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
  class << self

    def current
      Olympiad.live.first
    end

    def next_olympiad
      Olympiad.where("begins_at > ?", DateTime.now).order("begins_at ASC").limit(1).first
    end

  end
  # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

end
