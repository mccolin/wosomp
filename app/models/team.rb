# WOSOMP
# Team -- A single team, which exists for a single Olympiad

class Team < ActiveRecord::Base

  # Relationships:
  belongs_to :olympiad
  has_many :registrations
  has_many :users, :through=>:registrations

  # Scopes:
  scope :for_olympiad, lambda{|o| where(:olympiad_id=>o.id) }

  # Attributes:
  attr_accessible :olympiad_id, :name, :color1, :color2, :color1_code, :color2_code, :bio
  attr_accessible :user_ids


  def captains
    registrations.where(:captain=>true).includes(:user).map(&:user)
  end

  def athletes
    registrations.where(:athlete=>true).includes(:user).map(&:user)
  end

  def fans
    registrations.where(:athlete=>false).includes(:user).map(&:user)
  end
  alias_method :supporters, :fans

  def colors
    [color1, color2].join(" & ")
  end

end
