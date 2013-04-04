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

  # Update a team's properties:
  def update
    team_data = params[:team]
    begin
      team = Team.where(:id=>team_data[:id]).first
      if team && registration = Registration.on_team(team).for_user(current_user).first
        team.update_attributes(team_data) if registration.captain?
      end
    end
    flash[:success] = "Your team changes were saved successfully. Check them out:"
    redirect_to registration_olympiad_path(@olympiad, :page=>"team")
  end


  # Save a new team wall post:
  def save_post
    post_data = params[:team_post]
    begin
      post = TeamPost.create(post_data)
    rescue Exception => e
      flash[:error] = "Unable to save your post. Please try again."
    else
      flash[:success] = "Your post has been added to the team wall."
    end
    redirect_to registration_olympiad_path(@olympiad, :page=>"wall")
  end

  # Delete an existing team wall post:
  def delete_post
    if post = TeamPost.where(:id=>params[:post_id]).first
      post.destroy
      flash[:success] = "Your post has been deleted."
    end
    redirect_to registration_olympiad_path(@olympiad, :page=>"wall")
  end



  private

  def load_olympiad
    @olympiad = Olympiad.find_using_slug(params[:olympiad_id].to_s) if params[:olympiad_id]
  end

end

