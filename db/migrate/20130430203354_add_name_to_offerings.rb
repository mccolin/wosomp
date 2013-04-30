class AddNameToOfferings < ActiveRecord::Migration
  def change
    add_column :offerings, :name, :string, :after=>"sport_id"
  end
end
