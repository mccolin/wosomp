class ConvertMembershipsToRegistrations < ActiveRecord::Migration
  def up
    rename_table :memberships, :registrations
    add_column :registrations, :olympiad_id, :integer, :after=>:user_id
    add_column :registrations, :agree_waiver, :boolean, :default=>false, :after=>:uniform_name
    add_column :registrations, :agree_pay, :boolean, :default=>false, :after=>:uniform_name
    add_column :registrations, :paid, :boolean, :default=>false, :after=>:uniform_name
    add_column :registrations, :athlete, :boolean, :default=>true, :after=>:team_id
  end

  def down
    remove_column :registrations, :athlete
    remove_column :registrations, :paid
    remove_column :registrations, :agree_pay
    remove_column :registrations, :agree_waiver
    remove_column :registrations, :olympiad_id
    rename_table :registrations, :memberships
  end
end
