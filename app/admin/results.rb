ActiveAdmin.register Result do

  menu :priority => 8, :label => "Sports Results", :parent=>"Olympiads"

  # Scopes:
  scope :players
  scope :teams
  scope :overridden

  # Action Item buttons:
  action_item do
    link_to "Reset Result Caches", cache_reset_admin_results_path, :method=>:post
  end

  # Index:
  index do
    selectable_column
    column :offering
    column :registration
    column :team
    column :award
    column :points_athlete
    column :points_team
    column "Override" do |r|
      r.points_override? ? status_tag("Override",:error) : status_tag("Default",:ok)
    end
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
  filter :points_override

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
          r.team_result? ? status_tag("Team",:warn) : status_tag("Athlete",:warn)
        end
        row "Overridden" do |r|
          r.points_override? ? status_tag("Overridden",:error) : status_tag("Default",:ok)
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
      f.input :points_override,
        :hint=>"Check this to allow specifying specific athlete or team points values for this result",
        :input_html=>{
          :onchange=>"""
            if ($(this).is(':checked')) {
              $('#result_points_athlete').removeAttr('disabled');
              $('#result_points_team').removeAttr('disabled');
            } else {
              $('#result_points_athlete').attr('disabled', true);
              $('#result_points_team').attr('disabled', true);
            }"""
        }
    end
    f.inputs "Additional Notes" do
      f.input :note, :input_html=>{:rows=>3}, :hint=>"Special notes, indications, or anecdotes for the result"
    end
    f.buttons
  end


  # Triggers a counter-cache reset for all team and player rankings
  collection_action :cache_reset, :method => :post do
    Team.all.each {|t| t.update_result_caches }
    Registration.all.each {|r| r.update_result_caches }
    redirect_to admin_results_path(), :notice => "Result point and count caches for all teams and registrations reset"
  end


end
