class HomeController < ApplicationController
  
  def index
    render :file=>File.join(Rails.root,"public/teaser.html"), :layout=>nil and return if Rails.env.production?
    render :text=>"Hello WOSoMP"
  end
  
end
