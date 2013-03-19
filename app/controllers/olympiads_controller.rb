# WOSOMP
# OlympiadsController -- Information about Olympiads

class OlympiadsController < ApplicationController

  before_filter :authenticate_user!, :only=>[:register, :registration, :save_registration]

  before_filter :load_olympiad, :except=>[:index]

  before_filter :redirect_to_teaser


  # Show a list of historical events:
  def index
    @olympiads = Olympiad.order("`begins_at` DESC").all
  end

  # Display information about a single Olympiad:
  def show
  end

  # Location: Display information about the location of an Olympiad:
  def location
  end

  # Events: List the sports/events held in an Olympiad:
  def events
  end

  # Register: Sign up to participate in an Olympiad:
  def register
    if @registration = Registration.for_user(current_user).for_olympiad(@olympiad).first
      flash.now[:notice] = "You have already registered for this event. Feel free to make changes to your registration, below."
    else
      @registration = Registration.new
    end
  end

  # Registration: View/Edit your existing registration:
  def registration
    @registration = Registration.for_user(current_user).for_olympiad(@olympiad).first
    redirect_to :action=>"register" unless @registration
  end

  def save_registration
    begin
      reg_data = params[:registration]
      user_data = reg_data.delete(:user)
      User.transaction do
        current_user.update_attributes(user_data)
        reg_data[:user_id] = current_user.id
        #user_data[:birthday] = Date.strptime(user_data[:birthday], "%m/%d/%Y").to_s
        logger.info "Converted date: #{user_data[:birthday]} #{user_data[:birthday].inspect}"
        reg_id = reg_data.delete(:id)
        unless reg_id.blank?
          @registration = Registration.where(:id=>reg_id).first
          @registration.update_attributes(reg_data)
        else
          @registration = Registration.create(reg_data)
        end
        raise Exception.new("Unable to save your registration") if current_user.errors.any? || @registration.errors.any?
      end # transaction
    rescue Exception => e # ActiveRecord::RecordInvalid
      logger.debug "Unable to save Registration: #{e.message}"
      flash.now[:error] = "We were unable to save your registration. Correct the errors on the form before continuing."
      render :action=>"register"
      return
    else
      flash[:success] = "Awesome! Your registration was successfully saved. We'll see you at WOSoMP!"
      redirect_to :action=>"registration"
    end
  end


  private

  def load_olympiad
    @olympiad = Olympiad.find_using_slug(params[:id].to_s) if params[:id]
  end

end
