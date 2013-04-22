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
    column "Fees", :sortable=>:registration_fee do |o|
      "$#{o.registration_fee || 0} / $#{o.spectator_fee || 0} / $#{o.spectator_shirt_fee || 0}"
    end
    default_actions
  end

  # Show:
  show do
    attributes_table do
      row :name
      row "Athlete Fee" do
        "$#{olympiad.registration_fee} (#{olympiad.registrations.where(:athlete=>true).count()} registered)"
      end
      row "Spectator Fee" do
        "$#{olympiad.spectator_fee} (#{olympiad.registrations.where(:athlete=>false).count()} registered)"
      end
      row "Spectator Shirt Fee" do
        "$#{olympiad.spectator_shirt_fee} (#{olympiad.registrations.where(:athlete=>false, :uniform_shirt=>true).count()} registered)"
      end
      row "Registered Budget" do
        "<b style='color:#A00;'>$#{olympiad.registrations.sum(&:fee)}</b> (#{olympiad.registrations.count()} total guests)".html_safe
      end
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
    panel "Host Location" do
      attributes_table_for olympiad do
        row :location_name
        row :location_address
        row :location_city
        row :location_state
        row :location_zip
        row :location_info
      end
    end
    panel "Timing" do
      attributes_table_for olympiad do
        row :begins_at
        row :ends_at
        row :planning_begins_at
        row :planning_ends_at
        row :registration_begins_at
        row :registration_ends_at
      end
    end

    # Shirt Order:
    panel "Registrations / Shirt Order Details" do
      table_for olympiad.registrations.where("athlete = ? OR uniform_shirt = ?", true, true).includes(:team, :user).order(:team_id, :uniform_size) do
        column "Registration" do |reg|
          link_to reg.name, [:admin, reg]
        end
        column "Fee" do |reg|
          "$#{reg.fee}"
        end
        column :role
        column "Color" do |reg|
          reg.team ? reg.team.shirt_color.capitalize : nil
        end
        column "Size" do |reg|
          reg.athlete? || reg.uniform_shirt? ? reg.uniform_size : nil
        end
        column "Num" do |reg|
          reg.athlete? ? reg.uniform_number : nil
        end
        column "Name" do |reg|
          reg.athlete? ? reg.uniform_name : nil
        end
        column "" do |reg|
          link_to "View", [:admin, reg]
        end
      end # table

      size_counts = olympiad.registrations.with_uniform().group(:uniform_size).count()
      total_count = olympiad.registrations.with_uniform().count()
      table do
        tr do
          th "Total"
          %w(YM YL YXL S M L XL).each do |size|
            th size
          end
        end
        tr do
          td total_count
          %w(YM YL YXL S M L XL).each do |size|
            td "#{size_counts[size] || 0}"
          end
        end
      end

      color_counts = olympiad.registrations.with_uniform().group(:team_id).count()
      table do
        tr do
          olympiad.teams.order(:id).each do |team|
            th team.shirt_color
          end
        end
        tr do
          olympiad.teams.order(:id).each do |team|
            td "#{color_counts[team.id] || 0}"
          end
        end
      end

    end # panel
  end


  # Form:
  form do |f|
    f.inputs "Basics" do
      f.input :name
      f.input :registration_fee, :hint=>"Fee charged to participating athletes"
      f.input :spectator_fee, :hint=>"Fee charged to fans/supporters"
      f.input :spectator_shirt_fee, :hint=>"Additional fee charged to fans/supporters for a team shirt"
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
