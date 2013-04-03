class CreateTeamPosts < ActiveRecord::Migration
  def change
    create_table :team_posts do |t|
      t.integer :team_id
      t.integer :author_id
      t.integer :registration_id
      t.string :subject
      t.text :body

      t.timestamps
    end
    add_index :team_posts, :team_id
  end
end
