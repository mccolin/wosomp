class CreateOfferings < ActiveRecord::Migration
  def change
    create_table :offerings do |t|
      # Relationship Connectors:
      t.integer :olympiad_id
      t.integer :sport_id

      # Key-Value Hash Details:
      t.text :details

      t.timestamps
    end
  end
end
