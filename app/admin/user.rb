# WOSoMP
# Admin / Users

ActiveAdmin.register User do

  # Index Scopes:
  scope :all, :default=>true
  scope :admin  

  # Customize the Index:
  index do
    selectable_column
    column :id
    column :first_name
    column :last_name
    column :email
    column :admin do |u|
      u.admin? ? status_tag("Yes", :ok) : status_tag("No", :error)
    end
    default_actions
  end


  # Customize the Add/Edit Form:
  form do |f|
    f.inputs "User Details" do
      f.input :first_name
      f.input :last_name
      f.input :email
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
