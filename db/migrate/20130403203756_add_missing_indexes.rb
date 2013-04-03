class AddMissingIndexes < ActiveRecord::Migration
  def up
    add_index :offerings, [:olympiad_id, :sport_id]
    add_index :offerings, [:sport_id, :olympiad_id]
    add_index :registrations, [:user_id, :olympiad_id]
    add_index :registrations, :olympiad_id
    add_index :registrations, :team_id
    add_index :teams, :olympiad_id
  end

  def down
    remove_index :offerings, :name=>"index_offerings_on_olympiad_id_and_sport_id"
    remove_index :offerings, :name=>"index_offerings_on_sport_id_and_olympiad_id"
    remove_index :registrations, :name=>"index_registrations_on_olympiad_id"
    remove_index :registrations, :name=>"index_registrations_on_team_id"
    remove_index :registrations, :name=>"index_registrations_on_user_id_and_olympiad_id"
    remove_index :teams, :name=>"index_teams_on_olympiad_id"
  end
end
