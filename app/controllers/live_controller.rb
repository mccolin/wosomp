# WOSOMP
# LiveController -- Display live visualizations and displays of Olympiad
#  information, rankings, schedules, and more.

class LiveController < ApplicationController

  before_filter :load_olympiad


  # Live Event Display:
  def index
    @teams = @olympiad.teams.order("award_value_total DESC")
    @registrations = @olympiad.registrations.includes(:user).order("award_value_total DESC")
  end


  protected

  def load_olympiad
    @olympiad = if params[:id]
      Olympiad.find_by_slug(params[:id].to_s) || Olympiad.where(:id=>params[:id]).includes(:registrations, :teams).first
    else
      Olympiad.featured_olympiad(:registrations, :teams)
    end
  end

end
