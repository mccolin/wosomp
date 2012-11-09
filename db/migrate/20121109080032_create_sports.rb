class CreateSports < ActiveRecord::Migration
  def change
    create_table :sports do |t|
      # Sports have a name and description:
      t.string :name
      t.text :description

      # Opportunities to describe field of play, equipment, and rules:
      t.text :field
      t.text :equipment
      t.text :rules

      # Flags and variables for various settings are stored in details:
      t.text :details

      t.timestamps
    end
  end
end
