# WOSOMP
# HomeController -- User landing pages

class HomeController < ApplicationController

  layout "home"

  before_filter :redirect_to_teaser

  def index
    #flash.now[:info] = "This is the flash message"
    @current_olympiad = Olympiad.current
    @registerrable_olympiads = Olympiad.registration_open
    @planning_olympiads = Olympiad.planning_open
  end

end
