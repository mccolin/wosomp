# WOSoMP
# Admin / Olympiads

ActiveAdmin.register Olympiad do

  # Scopes:
  scope :all, :default=>true
  scope :live
  scope :registration_open
  scope :planning_open

  # Index:
  index do
    selectable_column
    #column :id
    column "Process", :sortable=>:registration_ends_at do |o|
      if o.is_live?
        status_tag("Live",:error)
      elsif o.is_registering?
        status_tag("Registration", :warn)
      elsif o.is_planning?
        status_tag("Planning", :ok)
      else
        status_tag(o.is_past? ? "Past" : "Future", :ok)
      end
    end
    column "Name", :sortable=>:name do |o|
      link_to(o.name, [:admin,o])
    end
    column "Sports" do |o|
      o.sports.count
    end
    column "Event Date", :sortable=>:begins_at do |o|
      o.begins_at.strftime("%b %d, %Y")
    end
    column "City", :location_city
    column "State", :location_state
    default_actions
  end

  # Show:
  show do
    attributes_table do
      row :name
      row :registration_fee
    end
    table_for olympiad.sports.order(:name) do
      column "Sports Offered" do |sport|
        link_to sport.name, [ :admin, sport ]
      end
    end
    table_for olympiad.teams.order(:name) do
      column "Participating Teams" do |team|
        link_to(team.name, [:admin, team])
      end
    end
    attributes_table do
      row :location_name
      row :location_address
      row :location_city
      row :location_state
      row :location_zip
      row :location_info
    end
    attributes_table do
      row :begins_at
      row :ends_at
      row :planning_begins_at
      row :planning_ends_at
      row :registration_begins_at
      row :registration_ends_at
    end
  end


  # Form:
  form do |f|
    f.inputs "Basics" do
      f.input :name
      f.input :registration_fee
    end
    f.inputs "Sports" do
      f.input :sports, :as=>:check_boxes
    end
    f.inputs "Location Details" do
      f.input :location_name, :hint=>"Venue name"
      f.input :location_address
      f.input :location_city
      f.input :location_state
      f.input :location_zip
      f.input :location_info, :input_html=>{:rows=>3}, :hint=>"Details regarding the venue itself, surrounding area, etc."
    end
    f.inputs "Calendar" do
      f.input :begins_at
      f.input :ends_at
      f.input :planning_begins_at
      f.input :planning_ends_at
      f.input :registration_begins_at
      f.input :registration_ends_at
    end
    f.inputs "Website Ancillary" do
      f.input :slug, :input_html=>{:disabled=>true}
    end
    f.buttons
  end



  before_filter :only => [:show, :edit, :update, :destroy] do
    @olympiad = Olympiad.where(:id=>params[:id].to_s).first() || Olympiad.where(:slug=>params[:id].to_s).first
    #@olympiad = Olympiad.find_by_slug!(params[:id])
  end

end
