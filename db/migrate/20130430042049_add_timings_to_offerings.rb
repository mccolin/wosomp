class AddTimingsToOfferings < ActiveRecord::Migration
  def change
    add_column :offerings, :location, :string, :after=>"sport_id"
    add_column :offerings, :begins_at, :time, :after=>"location"
    add_column :offerings, :ends_at, :time, :after=>"begins_at"
  end
end
