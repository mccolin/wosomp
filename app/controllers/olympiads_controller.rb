# WOSOMP
# OlympiadsController -- Information about Olympiads

class OlympiadsController < ApplicationController

  before_filter :authenticate_user!, :only=>[:register]

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
    @registration = Registration.new
  end

  def save_registration
    reg_data = params[:registration]
  end


  private

  def load_olympiad
    @olympiad = Olympiad.find_using_slug(params[:id].to_s) if params[:id]
  end

end
