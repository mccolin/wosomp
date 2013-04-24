ActiveAdmin.register_page "Check-In" do

  # Position Check-In page within the Dashboard Menu:
  menu :priority => 1, :label => "CHECK-IN", :parent=>"LIVE EVENT"

  # Action Item buttons for reviewing lists:
  action_item { link_to "All Registrations", [:admin, :registrations] }
  action_item { link_to "All Users", [:admin, :users] }

  # Display the Check-In Form and/or Results:
  content do
    render "check_in"
  end


  # Save an existing user's checkin, and display the information to the user:
  page_action :save, :method => :post do
    user_id = params[:checkin][:user]
    olympiad_id = params[:checkin][:olympiad]

    @registration = Registration.not_checked_in().where(:user_id=>user_id, :olympiad_id=>olympiad_id).includes(:user, :olympiad).first

    if @registration
      @registration.check_in!
      redirect_to admin_check_in_path(:r=>@registration.id), :notice => "#{@registration.user.name} successfully checked in to #{@registration.olympiad.name}"
    else
      redirect_to admin_check_in_path(), :alert => "Unable to find registration for that guest. Did you mean to create a new registration?"
    end
  end

  # Create a Walk-up Registration and display results:
  page_action :register, :method => :post do
    reg_data = params[:registration]
    user_data = reg_data.delete(:user)

    begin
      User.transaction do
        @user = User.new(user_data)
        @user.save

        @registration = Registration.new(reg_data)
        @registration.user = @user
        @registration.checked_in = true
        if @registration.athlete? || @registration.uniform_shirt?
          @registration.uniform_size = "L"
        end
        if @registration.athlete?
          @registration.uniform_name = @registration.user.last_name
          @registration.uniform_number = "W"
          @registration.agree_waiver = true
        end
        @registration.agree_pay = true
        @registration.save
      end # transaction

      if @user.errors.any? || @registration.errors.any?
        error_messages = {user: @user.errors.to_hash, registration: @registration.errors.to_hash}
        raise Exception.new("Exception saving new user and/or registration.")
      end

    rescue Exception=>e
      Rails.logger.error @user.errors
      redirect_to admin_check_in_path(), :alert => "Unable to register walk-on guest. Please try again."
    else
      redirect_to admin_check_in_path(:r=>@registration), :notice => "#{@registration.user.name} successfully signed up for #{@registration.olympiad.name} as a walk-on"
    end
  end

end
