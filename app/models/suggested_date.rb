# WOSOMP
# SuggestedDate -- A date suggested for hosting an event

class SuggestedDate < ActiveRecord::Base
  
  belongs_to :olympiad
  
  has_event_calendar :start_at_field=>:begins_at, :end_at_field=>:ends_at
  
end
