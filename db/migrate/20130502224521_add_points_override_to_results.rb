class AddPointsOverrideToResults < ActiveRecord::Migration
  def up
    add_column :results, :points_override, :boolean, :default=>false, :after=>"points_team"
    Result.update_all(:points_override=>false)
  end
  def down
    remove_column :results, :points_override
  end
end
