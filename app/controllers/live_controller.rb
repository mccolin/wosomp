# WOSOMP
# LiveController -- Display live visualizations and displays of Olympiad
#  information, rankings, schedules, and more.

class LiveController < ApplicationController

  before_filter :load_olympiad


  # Live Event Display:
  def show
    @teams = @olympiad.teams.order("points_total DESC")
    @registrations = @olympiad.registrations.includes(:user).order("points_total DESC")
  end


  # Athlete/Fan Event Check-in
  def checkin
  end

  # Search for an Athlete
  def checkin_search
    query = params[:q].downcase
    @users = User.where("LOWER(first_name) LIKE '#{query}%' OR LOWER(last_name) LIKE '#{query}%'").includes(:registrations)
  end


  protected

  def load_olympiad
    @olympiad = if params[:olympiad_id]
      Olympiad.where(:slug=>params[:olympiad_id].to_s).includes(:registrations, :teams).first || Olympiad.where(:id=>params[:olympiad_id]).includes(:registrations, :teams).first
    else
      Olympiad.featured_olympiad(:registrations, :teams)
    end
  end

end
