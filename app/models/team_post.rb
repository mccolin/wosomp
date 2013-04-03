# WOSOMP
# TeamPost -- A message written by a teammember to a team.

class TeamPost < ActiveRecord::Base

  # Relationships:
  belongs_to :team
  belongs_to :author, :class_name=>"User"
  belongs_to :registration

  # Scopes:
  scope :for_team, lambda{|t| where(:team_id=>t.id) }
  scope :by_user, lambda{|u| where(:author_id=>u.id) }

  # Attributes:
  attr_accessible :author_id, :body, :registration_id, :subject, :team_id


end
