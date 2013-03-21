class AddShirtColorToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :shirt_color, :string, :after=>"name"
  end
end
