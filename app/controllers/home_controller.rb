# WOSOMP
# HomeController -- User landing pages

class HomeController < ApplicationController

  layout "application"

  before_filter :redirect_to_teaser

  def index
    #flash.now[:info] = "This is the flash message"
    @current_olympiad = Olympiad.current
    @registerrable_olympiads = Olympiad.registration_open
    @planning_olympiads = Olympiad.planning_open
    render :layout=>"home"
  end

  def testenv
    render :text=>ENV.collect{|k,v| "#{k.ljust(40)} = #{v}"}.sort().join("\n"), :content_type=>"text/plain"
  end


end
