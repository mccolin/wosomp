class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      # Result linkages:
      t.integer :offering_id, :null=>false      # <= Link this result to a Sport in an Olympiad
      t.integer :registration_id                # <= If NULL, this is a team result
      t.integer :team_id, :null=>false          # <= Link this result to a team (or a player's team)

      # If an award is earned in this result, declare it:
      t.string :award, :limit=>12, :default=>"none"          # Medal or award earned (e.g., "gold", "silver")
      t.integer :points_athlete, :default=>0, :null=>false   # Ranking points earned by athlete
      t.integer :points_team, :default=>0, :null=>false      # Ranking points earned by team

      # Spot for short note:
      t.string :note

      # Usual hub-bub:
      t.timestamps
    end

    # Index result pivots:
    add_index :results, [:offering_id]
    add_index :results, [:registration_id, :points_athlete]
    add_index :results, [:team_id, :points_team]

    # Cache some values on teams:
    add_column :teams, :points_total, :integer, :default=>0, :after=>"bio"
    add_column :teams, :points_gold, :integer, :default=>0, :after=>"points_total"
    add_column :teams, :points_silver, :integer, :default=>0, :after=>"points_gold"
    add_column :teams, :points_bronze, :integer, :default=>0, :after=>"points_silver"
    add_column :teams, :count_total, :integer, :default=>0, :after=>"points_bronze"
    add_column :teams, :count_gold, :integer, :default=>0, :after=>"count_total"
    add_column :teams, :count_silver, :integer, :default=>0, :after=>"count_gold"
    add_column :teams, :count_bronze, :integer, :default=>0, :after=>"count_silver"
    add_index :teams, :points_total
    add_index :teams, :count_total

    # Cache some values on registrations:
    add_column :registrations, :points_total, :integer, :default=>0, :after=>"uniform_name"
    add_column :registrations, :points_gold, :integer, :default=>0, :after=>"points_total"
    add_column :registrations, :points_silver, :integer, :default=>0, :after=>"points_gold"
    add_column :registrations, :points_bronze, :integer, :default=>0, :after=>"points_silver"
    add_column :registrations, :count_total, :integer, :default=>0, :after=>"points_bronze"
    add_column :registrations, :count_gold, :integer, :default=>0, :after=>"count_total"
    add_column :registrations, :count_silver, :integer, :default=>0, :after=>"count_gold"
    add_column :registrations, :count_bronze, :integer, :default=>0, :after=>"count_silver"
    add_index :registrations, :points_total
    add_index :registrations, :count_total
  end
end
