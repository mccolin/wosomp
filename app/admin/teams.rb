# WOSoMP
# Admin / Teams

ActiveAdmin.register Team do

  # Scopes:
  scope :all, :default=>true

  # Index:
  index do
    selectable_column
    #column :id
    column "Name", :sortable=>:name do |t|
      link_to(t.name, [:admin,t])
    end
    column :olympiad, :sortable=>:olympiad_id
    column "Color", :sortable=>:color1 do |t|
      if t.color1 && t.color1_code
        %{<span style='color:#{t.color1_code}'>#{t.color1.capitalize}</span>}.html_safe
      elsif t.color1
        t.color1.capitalize
      else
        "Undecided"
      end
    end
    column "Members" do |t|
      t.users.count
    end
    default_actions
  end


  # Filters
  filter :olympiad
  filter :name
  filter :color1, :as=>:select, :collection=>Team.select("DISTINCT color1").map(&:color1)


  # Show:
  show do
    attributes_table do
      row :name
      row :colors
      row :olympiad
      row :bio
      row :created_at
      row :updated_at
    end
    table_for team.registrations.includes(:user).order("users.last_name, users.first_name") do
      column "Athletes and Supporters" do |reg|
        link_to(reg.user.name, [:admin, reg.user]) + " - #{reg.role.to_s.capitalize}"
      end
    end
  end


  # Form:
  form do |f|
    f.inputs "Basics" do
      f.input :name
      f.input :olympiad
      f.input :color1, :hint=>"Team's primary (shirt) color"
      f.input :color2, :hint=>"Team's secondary color (if applicable)"
      f.input :color1_code, :hint=>"HTML color code for primary color"
      f.input :color2_code, :hint=>"HTML color code for secondary color"
      f.input :bio, :input_html=>{:rows=>3}, :hint=>"Provide a story, background, or trash talk for the team"
    end
    f.inputs "Athletes and Supporters" do
      f.input :users, :as=>:check_boxes
    end
    f.buttons
  end


end