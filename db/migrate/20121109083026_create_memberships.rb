class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      # Link the athlete to their team:
      t.integer :user_id
      t.integer :team_id

      # Mark if this athlete is the captain:
      t.boolean :captain

      # Uniform Details:
      t.string :uniform_size, :limit=>3
      t.string :uniform_number, :limit=>4
      t.string :uniform_name, :limit=>12

      t.timestamps
    end
  end
end
