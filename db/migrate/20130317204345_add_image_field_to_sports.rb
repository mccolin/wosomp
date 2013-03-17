class AddImageFieldToSports < ActiveRecord::Migration
  def change
    add_column :sports, :image, :string
  end
end
