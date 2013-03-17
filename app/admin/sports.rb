# WOSoMP
# Admin / Sports

ActiveAdmin.register Sport do

  # Scopes:
  scope :all, :default=>true

  scope :team_sports
  scope :individual_sports
  scope :bracket
  scope :ranked

  # Index:
  index do
    selectable_column
    column :id
    column :name
    column :style
    column :num_per_team
    column :tournament_style
    column "Times Played" do |s|
      s.offerings.count
    end
    default_actions
  end

  # Show:
  show do
    attributes_table do
      row :name
      row :num_per_team
      row :num_teams
      row :tournament_style
      row :description
    end
    table_for sport.olympiads.order("begins_at DESC") do
      column "Olympiads Including" do |olympiad|
        link_to olympiad.name, [ :admin, olympiad ]
      end
    end
    attributes_table do
      row :image
      row :description
      row :field
      row :equipment
      row :rules
    end
  end

  # Form:
  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :olympiads, :as => :check_boxes
      f.input :image, :hint=>"Filename of image under /images/sports"
      f.input :num_teams
      f.input :num_per_team
      #t.input :tournament_style, :as=>:select, :collection=>%w(bracket ranking)
      f.input :description, :input_html=>{:rows=>3}
      f.input :field, :input_html=>{:rows=>3}
      f.input :equipment, :input_html=>{:rows=>3}
      f.input :rules, :input_html=>{:rows=>3}
    end
    f.buttons
  end


  # before_filter :only => [:show, :edit, :update, :destroy] do
  #   @olympiad = Olympiad.where(:id=>params[:id].to_s).first() || Olympiad.where(:slug=>params[:id].to_s).first
  #   #@olympiad = Olympiad.find_by_slug!(params[:id])
  # end

end
