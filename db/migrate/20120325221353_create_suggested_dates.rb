# WOSoMP
#

class CreateSuggestedDates < ActiveRecord::Migration
  def change
    create_table :suggested_dates do |t|
      # Link a suggestion to an Olympiad:
      t.integer :olympiad_id, :null=>false
      
      # Give it parameters:
      t.datetime :begins_at
      t.datetime :ends_at

      # Cache a total vote score:
      t.integer :score, :default=>0
      
      # And details:
      t.string :location_name
      t.text :notes
      
      # Bookkeeping:
      t.timestamps
    end
    
    add_index :suggested_dates, :olympiad_id
  end
end
