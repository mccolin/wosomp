# WOSoMP
#

class AddAdminSupportToUser < ActiveRecord::Migration
  def up
    add_column :users, :admin, :boolean, :default=>false, :null=>false

    User.create! do |u|
      u.email = "admin@example.com"
      u.password = "password"
      u.admin = true
    end
  end

  def down
    remove_column :users, :admin
    User.find_by_email("admin@example.com").try(:delete)
  end
end
