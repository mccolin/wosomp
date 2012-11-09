# WOSOMP
# OlympiadsController -- Information about Olympiads

class OlympiadsController < ApplicationController
  
  # Show a list of historical events:
  def index
    @olympiads = Olympiad.order("`begins_at` DESC").all
  end
  
  # Display information about a single Olympiad:
  def show
    @olympiad = Olympiad.find_using_slug(params[:id])
  end
  
end
