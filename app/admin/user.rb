# WOSoMP
# Admin / Users

ActiveAdmin.register User do

  # Index Scopes:
  scope :all, :default=>true
  scope :admin

  # Customize the Index:
  index do
    selectable_column
    #column :id
    column "Name" do |u|
      link_to(u.name, [:admin, u])
    end
    column :email
    column :admin do |u|
      u.admin? ? status_tag("Yes", :ok) : status_tag("No", :error)
    end
    default_actions
  end

  # Filters
  filter :first_name
  filter :last_name
  filter :email
  filter :birthday
  filter :gender
  filter :admin

  # Show:
  show do
    attributes_table do
      row :name
      row :email
      if user.facebook_id?
        row :facebook_id
      end
      row :gender
      row :birthday
      row :bio
      row :address
      # row :address_street
      # row :address_city
      # row :address_state
      # row :address_zip
    end
    table_for user.registrations.includes(:olympiad, :team).order("olympiads.begins_at DESC") do
      column "Olympiads and Team Memberships" do |reg|
        %{
          #{ reg.olympiad.nil? ? "Olympiad Info Missing" : link_to(reg.olympiad.try(:name), [:admin, reg.olympiad]) } -
          #{ reg.team.nil? ? "No Team Set" : link_to(reg.try(:team).try(:name), [:admin, reg.team]) } -
          #{ reg.role.to_s.capitalize }
        }.html_safe
      end
    end
    attributes_table do
      row :current_sign_in_at
      row :last_sign_in_at
      row :sign_in_count
    end
  end


  # Customize the Add/Edit Form:
  form do |f|
    f.inputs "User Details" do
      f.input :first_name
      f.input :last_name
      f.input :email
      #f.input :gender
      f.input :birthday
      f.input :bio, :input_html=>{:rows=>3}
    end
    f.inputs "Website Account" do
      f.input :password
      f.input :password_confirmation
      f.input :admin, :label => "WOSoMP Administrator"
    end
    f.buttons
  end


  # Properly handle user creation and edit:
  create_or_edit = Proc.new {
    @user = User.find_or_create_by_id(params[:id])
    @user.admin = params[:user][:admin]
    @user.attributes = params[:user].delete_if do |k, v|
      (k == "admin") ||
      (["password", "password_confirmation"].include?(k) && v.empty? && !@user.new_record?)
    end
    if @user.save
      redirect_to :action => :show, :id => @user.id
    else
      render active_admin_template((@user.new_record? ? 'new' : 'edit') + '.html.erb')
    end
  }
  member_action :create, :method => :post, &create_or_edit
  member_action :update, :method => :put, &create_or_edit

end
