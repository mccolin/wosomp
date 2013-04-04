# WOSOMP
# OlympiadsController -- Information about Olympiads

class TeamsController < ApplicationController

  before_filter :load_olympiad


  # Show a list of teams for an Olympiad:
  def index
    @teams = @olympiad.teams.includes(:registrations, :users, :posts).order(:name)
  end

  # Display information about a single Team:
  def show
    @team = Team.where(:id=>params[:id]).first
  end



  private

  def load_olympiad
    @olympiad = Olympiad.find_using_slug(params[:olympiad_id].to_s) if params[:olympiad_id]
  end

end

