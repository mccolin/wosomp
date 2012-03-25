# WOSOMP
# 

class CreateOlympiads < ActiveRecord::Migration
  def change
    create_table :olympiads do |t|
      # Each Olympics has a name and slug:
      t.string :name, :null=>false
      t.string :slug
      
      # Scheduled Event Date Range:
      t.datetime :begins_at
      t.datetime :ends_at
      
      # Planned Date Selection Period:
      t.datetime :planning_begins_at
      t.datetime :planning_ends_at
      
      # Planned Registration Date Ranges:
      t.datetime :registration_begins_at
      t.datetime :registration_ends_at
      
      # Registration Details:
      t.integer :registration_fee
      
      # Location Details:
      t.string :location_name
      t.string :location_address
      t.string :location_city
      t.string :location_state
      t.string :location_zip
      t.text :location_info
            
      # Modification tracking:
      t.timestamps
    end
    
    add_index :olympiads, :slug
    add_index :olympiads, [:begins_at, :ends_at], :name=>"index_event_dates"
    add_index :olympiads, [:registration_begins_at, :registration_ends_at], :name=>"index_registration_dates"
    add_index :olympiads, [:planning_begins_at, :planning_ends_at], :name=>"index_planning_dates"
    
  end
end
