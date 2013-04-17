# WOSOMP
# Team -- A single team, which exists for a single Olympiad

class Team < ActiveRecord::Base

  # Relationships:
  belongs_to :olympiad
  has_many :registrations
  has_many :users, :through=>:registrations
  has_many :posts, :class_name=>"TeamPost"
  has_many :results

  # Scopes:
  scope :for_olympiad, lambda{|o| where(:olympiad_id=>o.id) }

  # Attributes:
  attr_accessible :olympiad_id, :name, :shirt_color, :color1, :color2, :color1_code, :color2_code, :bio,
    :points_total, :points_gold, :points_silver, :points_bronze, :count_total, :count_gold, :count_silver,
    :count_bronze
  attr_accessible :user_ids

  def self.shirt_colors
    %w(black blue brown green gold gray kiwi heather maroon purple orange red royal sand teal)
  end


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

  def member?(user)
    users.include?(user)
  end


end
