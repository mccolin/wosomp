# WOSOMP
# LiveController -- Display live visualizations and displays of Olympiad
#  information, rankings, schedules, and more.

class LiveController < ApplicationController

  before_filter :load_olympiad


  # Live Event: Initial Load:
  def show
  end

  # Live Event: Team Rankings:
  def teams
    @teams = @olympiad.teams.order("points_total DESC")
    render :layout=>nil && return if request.xhr?
  end

  # Live Event: Athlete Rankings:
  def athletes
    @registrations = @olympiad.registrations.athletes().includes(:user, :team).order("points_total DESC")
    @men = @registrations.select{|r| r.user.male? }
    @women = @registrations.select{|r| r.user.female? }
    render :layout=>nil && return if request.xhr?
  end

  # Live Event: Schedule:
  def schedule
    @offerings = @olympiad.offerings.includes(:sport).order(:begins_at, "sports.name")
    render :layout=>nil && return if request.xhr?
  end

  # Live Event: Media:
  def media
    @hashtag = "wosomp"
    render :layout=>nil && return if request.xhr?
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
