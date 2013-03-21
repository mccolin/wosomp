class AddShirtOptInToRegistration < ActiveRecord::Migration
  def change
    add_column :registrations, :uniform_shirt, :boolean, :default=>true, :after=>"captain"
    add_column :olympiads, :spectator_shirt_fee, :integer, :after=>"spectator_fee"
  end
end
