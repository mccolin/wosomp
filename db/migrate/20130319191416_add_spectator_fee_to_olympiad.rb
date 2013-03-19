class AddSpectatorFeeToOlympiad < ActiveRecord::Migration
  def change
    add_column :olympiads, :spectator_fee, :integer, :after=>"registration_fee"
  end
end
