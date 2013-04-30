ActiveAdmin.register Offering do

  menu :priority => 2, :label => "Sports Offerings", :parent=>"Olympiads"

  # Index:
  index do
    selectable_column
    column :olympiad
    column :sport
    column :location
    column "Begins" do |o|
      o.begins_at.try(:strftime, "%-I:%M %p")
    end
    column "Ends" do |o|
      o.ends_at.try(:strftime, "%-I:%M %p")
    end
    default_actions
  end

  # Filters
  filter :olympiad
  filter :sport



  # Show:
  show do
    attributes_table do
      row :id
      row :olympiad
      row :sport
      #row :details
      row :location
      row "Begins" do |o|
        o.begins_at.try(:strftime, "%-I:%M %p")
      end
      row "Ends" do |o|
        o.ends_at.try(:strftime, "%-I:%M %p")
      end
    end
  end

  # Form:
  form do |f|
    f.inputs "Describe the Event" do
      f.input :olympiad, :as => :select
      f.input :sport, :as => :select
      #f.input :details, :input_html=>{:rows=>3}
    end
    f.inputs "Schedule the Event" do
      f.input :location, :hint=>"Where within the venue will this sport be held?"
      f.input :begins_at, :as=>:select, :collection=>Offering.time_slots, :hint=>"What is the scheduled start time for this event?"
      f.input :ends_at, :as=>:select, :collection=>Offering.time_slots, :hint=>"What is the scheduled end time for this event?"
    end
    f.buttons
  end


end
