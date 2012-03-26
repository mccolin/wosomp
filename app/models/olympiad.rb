# WOSOMP
# Olympiad -- A single olympics

class Olympiad < ActiveRecord::Base
  
  # Relationships:
  has_many :suggested_dates
  
  # Scopes:
  scope :live, where("`begins_at` < ? AND `ends_at` > ?", DateTime.now, DateTime.now).order("`begins_at` ASC")
  scope :registration_open, where("`registration_begins_at` < ? AND `registration_ends_at` > ?", DateTime.now, DateTime.now).order("`begins_at` ASC")
  scope :planning_open, where("`planning_begins_at` < ? AND `planning_ends_at` > ?", DateTime.now, DateTime.now).order("`begins_at` ASC")
  
  # Invocations:
  is_sluggable :name, :slug_column=>:slug
  
  
  
  # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
  class << self
    
    def current
      Olympiad.live.first
    end
    
    def next_olympiad
      Olympiad.order("`begins_at` ASC").limit(1).first
    end
    
  end
  # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
  
end
