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
  attr_accessible :olympiad_id, :name, :shirt_color, :color1, :color2, :color1_code, :color2_code, :bio
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

  # The total number of medals/awards won (not to be confused with score):
  def award_total_count
    award_gold_count + award_silver_count + award_bronze_count
  end

  def award_gold_score; award_gold_count * 9; end
  def award_silver_score; award_silver_count * 6; end
  def award_bronze_score; award_bronze_count * 3; end

end
