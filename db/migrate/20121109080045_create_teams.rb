class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.integer :olympiad_id
      t.string :name, :null=>false
      t.string :color1
      t.string :color2
      t.string :color1_code
      t.string :color2_code
      t.text :bio

      t.timestamps
    end
  end
end
