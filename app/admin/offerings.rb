ActiveAdmin.register Offering do

  menu :priority => 2, :label => "Sports Offerings", :parent=>"Olympiads"

  # Index:
  index do
    selectable_column
    column :olympiad
    column :sport
    # column :location
    # column :begins_at
    # column :ends_at
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
      row :details
      # row :location
      # row :begins_at
      # row :ends_at
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
      # f.input :location, :hint=>"Where within the venue will this sport be held?"
      # f.input :begins_at, :hint=>"What is the scheduled start time for this event?"
      # f.input :ends_at, :hint=>"What is the scheduled end time for this event?"
    end
    f.buttons
  end


end