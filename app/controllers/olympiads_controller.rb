# WOSOMP
# OlympiadsController -- Information about Olympiads

class OlympiadsController < ApplicationController
  
  # Show a list of historical events:
  def index
    @olympiads = Olympiad.order("`begins_at` DESC").all
  end
  
end
