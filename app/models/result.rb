class Result < ActiveRecord::Base
  attr_accessible :award, :award_value_player, :award_value_team, :match_number, :match_round, :match_score, :offering_id, :registration_id, :team_id, :type
end
