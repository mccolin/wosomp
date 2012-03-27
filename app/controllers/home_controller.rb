# WOSOMP
# HomeController -- User landing pages

class HomeController < ApplicationController
  
  before_filter :authenticate_user!
  
  def index
    flash.now[:info] = "You are wonderful and awesome!"
    @current_olympiad = Olympiad.current
    @registerrable_olympiads = Olympiad.registration_open
    @planning_olympiads = Olympiad.planning_open
  end
  
end
