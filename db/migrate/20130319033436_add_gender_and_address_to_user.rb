class AddGenderAndAddressToUser < ActiveRecord::Migration
  def change
    add_column :users, :gender, :string, :limit=>"female".length
    add_column :users, :address_street, :string
    add_column :users, :address_city, :string
    add_column :users, :address_state, :string, :limit=>2
    add_column :users, :address_zip, :string, :limit=>5
  end
end
