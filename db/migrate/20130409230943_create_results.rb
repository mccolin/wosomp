class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      # Result linkages:
      t.integer :offering_id, :null=>false      # <= Link this result to a Sport in an Olympiad
      t.integer :registration_id                # <= If NULL, this is a team result
      t.integer :team_id, :null=>false          # <= Link this result to a team (or a player's team)

      # Label/name the grouping (i.e., "mini-team") if applicable:
      t.string :group_name, :limit=>12

      # Describe the tournament match and score applied:
      t.integer :match_round                    # Round of a tournamnet/bracket
      t.integer :match_number                   # Match number within bracket
      t.integer :match_score                    # Score earned by this player/team (opponent has matching result)

      # If an award is earned in this result, declare it:
      t.string :award, :limit=>12, :default=>"none"               # Medal or award earned (e.g., "gold", "silver")
      t.integer :award_value_player, :default=>0, :null=>false    # Ranking points earned by player
      t.integer :award_value_team, :default=>0, :null=>false      # Ranking points earned by team


      # Usual hub-bub:
      t.timestamps
    end

    # Index result pivots:
    add_index :results, [:offering_id, :match_round, :match_number]
    add_index :results, [:team_id, :award_value_team]
    add_index :results, [:registration_id, :award_value_player]

    # Cache some values on teams:
    add_column :teams, :award_value_total, :integer, :default=>0, :after=>"bio"
    add_column :teams, :award_gold_count, :integer, :default=>0, :after=>"award_value_total"
    add_column :teams, :award_silver_count, :integer, :default=>0, :after=>"award_gold_count"
    add_column :teams, :award_bronze_count, :integer, :default=>0, :after=>"award_silver_count"
    add_index :teams, :award_value_total

    # Cache some values on registrations:
    add_column :registrations, :award_value_total, :integer, :default=>0, :after=>"uniform_name"
    add_column :registrations, :award_gold_count, :integer, :default=>0, :after=>"award_value_total"
    add_column :registrations, :award_silver_count, :integer, :default=>0, :after=>"award_gold_count"
    add_column :registrations, :award_bronze_count, :integer, :default=>0, :after=>"award_silver_count"
    add_index :registrations, :award_value_total
  end
end
