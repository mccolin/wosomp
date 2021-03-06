# WOSoMP
# Admin / Teams

ActiveAdmin.register Team do

  menu :priority => 4, :label => "Teams", :parent=>"Olympiads"

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
      if t.color1
        %{<span style='color:#{t.color1_code};font-weight:bold;'>#{t.color1.capitalize}</span>}.html_safe
      else
        "Undecided"
      end
    end
    column :shirt_color
    column "Members" do |t|
      t.users.count
    end
    column "Points", :sortable=>:points_total do |t|
      "<strong>#{t.points_total}</strong> (#{t.points_gold}G / #{t.points_silver}S / #{t.points_bronze}B)".html_safe
    end
    column "Counts", :sortable=>:count_total do |t|
      "<strong>#{t.count_total}</strong> (#{t.count_gold}G / #{t.count_silver}S / #{t.count_bronze}B)".html_safe
    end
    default_actions
  end


  # Filters
  filter :olympiad
  filter :name
  filter :shirt_color
  filter :color1, :as=>:select, :collection=>Team.select("DISTINCT color1").map(&:color1)


  # Show:
  show do
    attributes_table do
      row :name
      row :colors
      row :shirt_color
      row :olympiad
      row :bio
      row :created_at
      row :updated_at
    end
    panel "Athletic Results" do
      attributes_table_for team do
        row "Ranking Points" do |t|
          "#{t.points_total} points from #{t.count_total} medals"
        end
        row "Medal Points" do |t|
          "Gold: #{t.points_gold}pts, Silver: #{t.points_silver}pts, Bronze: #{t.points_bronze}pts"
        end
        row "Medal Counts" do |t|
          "Gold: #{t.count_gold}, Silver: #{t.count_silver}, Bronze: #{t.count_bronze}"
        end
      end

      # Detailed Results:
      table_for team.results.includes(:offering,:registration).order("results.offering_id, results.points_team DESC, results.award") do
        #column :offering
        column "Sport Results" do |result|
          link_to(result.offering.sport.name, [:admin, result.offering])
        end
        #column :registration
        column "Athlete" do |result|
          result.registration ? link_to(result.registration.user.name, [:admin, result.registration]) : "N/A"
        end
        column :award
        column :points_athlete
        column :points_team
        column :note
      end # table

      # Detailed Results:
      table_for team.registrations.athletes().includes(:user).order("registrations.points_total DESC, registrations.count_total DESC, users.last_name, users.first_name") do
        column "Athlete Results" do |reg|
          link_to(reg.user.name, [:admin, reg])
        end
        column "Rank Pts" do |reg|
          reg.points_total
        end
        column "Medal Count" do |reg|
          reg.count_total
        end
        column "Gold" do |reg|
          reg.count_gold
        end
        column "Silver" do |reg|
          reg.count_silver
        end
        column "Bronze" do |reg|
          reg.count_bronze
        end
      end # table
    end

  end


  # Form:
  form do |f|
    f.inputs "Basics" do
      f.input :name
      f.input :olympiad
      f.input :shirt_color, :as=>:select, :collection=>Team.shirt_colors, :hint=>"Shirt color for printing/ordering purposes"
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
