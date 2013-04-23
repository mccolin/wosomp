ActiveAdmin.register Result do

  menu :priority => 8, :label => "Sports Results", :parent=>"Olympiads"

  # Scopes:
  scope :players
  scope :teams

  # Index:
  index do
    selectable_column
    column :offering
    column :registration
    column :team
    column :award
    column :points_athlete
    column :points_team
    column :note
    default_actions
  end

  # Filters
  filter :offering
  filter :registration
  filter :team
  filter :award, :as => :select, :collection=>Result.result_types
  filter :points_athlete
  filter :points_team

  # Show:
  show do
    attributes_table do
      row :id
      row :offering
      row :registration
      row :team
      row :created_at
      row :updated_at
    end
    panel "Award" do
      attributes_table_for result do
        row :award
        row "Type" do |r|
          r.team_result? ? status_tag("Team",:warn) : status_tag("Athlete",:error)
        end
        row :points_athlete
        row :points_team
        row :note
      end
    end
  end

  # Form:
  form do |f|
    f.inputs "Connections" do
      f.input :offering, :as => :select
      f.input :registration, :as => :select
      f.input :team, :as => :select, :hint=>"Be sure that for player results, you select correct player team"
    end
    f.inputs "Award/Result Details" do
      f.input :award, :as => :select, :collection=>Result.result_types, :hint=>"Select the resulting award (gold, silver, bronze, etc.)"
      f.input :points_athlete, :input_html=>{:disabled=>true}, :hint=>"(auto-set) Points that will be awarded to the Athlete for ranking purposes"
      f.input :points_team, :input_html=>{:disabled=>true}, :hint=>"(auto-set) Points that will be awarded to the Team for ranking purposes"
      f.input :note, :input_html=>{:rows=>3}, :hint=>"Special notes, indications, or anecdotes for the result"
    end
    f.buttons
  end


end
