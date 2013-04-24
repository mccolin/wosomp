ActiveAdmin.register_page "Enter Result" do

  # Position Check-In page within the Dashboard Menu:
  menu :priority => 1, :label => "ENTER RESULT", :parent=>"LIVE EVENT"

  # Action Item buttons for reviewing lists:
  action_item { link_to "All Results", [:admin, :results] }

  # Display the Check-In Form and/or Results:
  content do
    render "results_form"
    #render "enter_result"
  end


  # Save a result (destructively overwrites existing results for the same offering)
  page_action :save, :method => :post do
    result_data = params[:result]
    begin
      @result = Result.new(result_data)
      @result.save()

    rescue Exception => e
      redirect_to admin_enter_result_path(), :alert => "Unable to save that Result: #{e.message}"
    else
      redirect_to admin_enter_result_path(:r=>@result.id), :notice => "#{@result.award.capitalize} result for #{@result.offering.sport.name} / #{@result.registration ? @result.registration.uniform_name : @result.team.name} successfully saved"
    end

  end


  # Save multiple results:
  page_action :multi_save, :method => :post do
    begin
      offering_id = params[:results][:offering_id].to_i
      @offering = Offering.find(offering_id)
      raise Exception.new("You must select a valid sport to save results.") unless @offering

      result_set = Array.new
      award_strings = params[:results][:awards]
      award_strings.each do |str|
        award, team_id, registration_id = str.split("-")
        @result = Result.new(:award=>award, :offering_id=>@offering.id)
        if registration_id.to_i > 0
          @registration = Registration.find(registration_id)
          @result.registration = @registration
          @result.team = @registration.team
        elsif team_id.to_i > 0
          @team = Team.find(team_id)
          @result.team = @team
        end
        @result.save
        result_set << @result

        # TODO: REPLACE EXISTING AWARD-OFFERING PAIRS IF THEY EXIST
      end

    rescue Exception => e
      redirect_to admin_enter_result_path(), :alert => "There was an error saving your result: #{e.message}"
    else
      redirect_to admin_enter_result_path(), :notice => "Successfully saved #{result_set.count} new result(s)"
    end # begin
  end


end
