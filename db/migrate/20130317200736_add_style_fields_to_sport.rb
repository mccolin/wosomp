class AddStyleFieldsToSport < ActiveRecord::Migration
  def change
    add_column :sports, :num_teams, :integer, :default=>2
    add_column :sports, :num_per_team, :integer, :default=>1
    add_column :sports, :tournament_style, :string, :default=>"bracket"
  end
end
