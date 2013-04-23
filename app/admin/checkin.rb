ActiveAdmin.register_page "Check-In" do

  # Position Check-In page within the Dashboard Menu:
  menu :priority => 1, :label => "CHECK-IN", :parent=>"Olympiads"

  # Action Item buttons for reviewing lists:
  action_item { link_to "All Registrations", [:admin, :registrations] }
  action_item { link_to "All Users", [:admin, :users] }

  # Display the Check-In Form and/or Results:
  content do
    render "check_in"
  end


  # Save an existing user's checkin, and display the information to the user:
  page_action :save, :method => :post do
    Rails.logger.info "You are checking in!!!"
    Rails.logger.info "You are checking in!!!"
    Rails.logger.info "You are checking in!!!"

    user_id = params[:checkin][:user]
    olympiad_id = params[:checkin][:olympiad]

    @registration = Registration.where(:user_id=>user_id, :olympiad_id=>olympiad_id).includes(:user, :olympiad).first

    if @registration
      @registration.check_in!
      redirect_to admin_check_in_path(:r=>@registration.id), :notice => "#{@registration.user.name} successfully checked in to #{@registration.olympiad.name}"
    else
      redirect_to admin_check_in_path(), :error => "Unable to find registration for that guest. Did you mean to create a new registration?"
    end
  end

end
