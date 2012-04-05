# WOSoMP
#

class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :facebook_id, :integer, :limit=>8, :after=>"email"
    add_column :users, :bio, :text, :before=>"created_at"

    add_index :users, :facebook_id
  end
end
