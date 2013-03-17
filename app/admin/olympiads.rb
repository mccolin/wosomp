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
    column :id
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
    column :name
    column "Event Date", :sortable=>:begins_at do |o|
      o.begins_at.strftime("%b %d, %Y")
    end
    column "City", :location_city
    column "State", :location_state
    default_actions
  end


  # sluggable_finder = Proc.new {
  #   @olympiad = Olympiad.where(:id=>params[:id]).first() || Olympiad.where(:slug=>params[:id]).first
  # }

  # member_action :show, :method=>:get, &sluggable_finder
  # member_action :edit, :method=>:get, &sluggable_finder
  #member_action :update, :method=>:put, &sluggable_finder

  before_filter :only => [:show, :edit, :update, :destroy] do
    @olympiad = Olympiad.where(:id=>params[:id].to_s).first() || Olympiad.where(:slug=>params[:id].to_s).first
    #@olympiad = Olympiad.find_by_slug!(params[:id])
  end

end
