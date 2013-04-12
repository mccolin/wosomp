class AddCheckedInToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :checked_in, :boolean, :default=>false, :after=>"paid"
  end
end
