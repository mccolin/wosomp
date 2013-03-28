# WOSoMP
# Admin / Registration

ActiveAdmin.register Registration do

  # Scopes:
  scope :all, :default=>true
  scope :captains
  scope :athletes
  scope :spectators

  # Index:
  index do
    selectable_column
    column :olympiad
    column :user
    column :team
    column "Shirt", :sortable=>:uniform_shirt do |r|
      r.uniform_shirt? ? status_tag("Yes",:ok) : status_tag("No",:error)
    end
    column "No", :sortable=>:uniform_number do |r|
      r.uniform_number
    end
    column "Name", :sortable=>:uniform_name do |r|
      r.uniform_name
    end
    column "Size", :sortable=>:uniform_size do |r|
      r.uniform_size
    end
    default_actions
  end


  # Filters
  filter :olympiad
  filter :user
  filter :team
  filter :captain
  filter :athlete
  filter :uniform_shirt
  filter :uniform_size, :as=>:select, :collection=>%w(S M L XL YXL YL YM)


  # Show:
  show do
    panel "Connections" do
      attributes_table_for registration do
        row :olympiad
        row :user
        row :team
        row :athlete
        row :captain
        row "Fee" do |reg|
          "$#{reg.fee}"
        end
      end
    end
    if registration.athlete? || registration.uniform_shirt?
      panel "Shirt" do
        attributes_table_for registration do
          row "Receives Uniform?" do |reg|
            reg.uniform_shirt? ? status_tag("Yes", :ok) : status_tag("No", :warn)
          end
          row :uniform_size
          if registration.athlete?
            row :uniform_name
            row :uniform_number
          end
        end
      end
    end
    panel "Agreements, Timing" do
      attributes_table_for registration do
        row "Agrees to Pay?" do |reg|
          reg.agree_pay? ? status_tag("Yes", :ok) : status_tag("No", :warn)
        end
        row "Agrees to Waiver?" do |reg|
          reg.agree_waiver? ? status_tag("Yes", :ok) : status_tag("No", :warn)
        end
        row "Has Paid?" do |reg|
          reg.paid? ? status_tag("Yes", :ok) : status_tag("No", :warn)
        end
        row :created_at
        row :updated_at
      end
    end
  end


  # Form:
  form do |f|
    f.inputs "Account" do
      f.input :user
      f.input :olympiad
      f.input :team
      f.input :athlete
      f.input :captain
    end
    f.inputs "Outfit" do
      f.input :uniform_shirt
      f.input :uniform_size, :as=>:select, :collection=>%w(S M L XL YXL YL YM)
      f.input :uniform_name, :input_html=>{:maxlength=>12}
      f.input :uniform_number, :input_html=>{:maxlength=>2}
    end
    f.inputs "Agreements" do
      f.input :agree_pay, :as=>:radio
      f.input :agree_waiver, :as=>:radio
      f.input :paid, :as=>:radio
    end
    f.buttons
  end


end
