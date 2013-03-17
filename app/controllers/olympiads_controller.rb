# WOSOMP
# OlympiadsController -- Information about Olympiads

class OlympiadsController < ApplicationController

  before_filter :authenticate_user!, :only=>[:register]

  # Show a list of historical events:
  def index
    @olympiads = Olympiad.order("`begins_at` DESC").all
  end

  # Display information about a single Olympiad:
  def show
    @olympiad = Olympiad.find_using_slug(params[:id].to_s)
  end

  # Location: Display information about the location of an Olympiad:
  def location
    @olympiad = Olympiad.find_using_slug(params[:id].to_s)
    render :text=>"Location"
  end

  # Events: List the sports/events held in an Olympiad:
  def events
    @olympiad = Olympiad.find_using_slug(params[:id].to_s)
    render :text=>"Events"
  end

  # Register: Sign up to participate in an Olympiad:
  def register
    @olympiad = Olympiad.find_using_slug(params[:id].to_s)
    render :text=>"Registration Form for #{@olympiad.name}"
  end

end
