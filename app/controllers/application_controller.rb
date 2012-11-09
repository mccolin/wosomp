class ApplicationController < ActionController::Base
  protect_from_forgery
  

  # Authentication for Admin Super Users:
  def authenticate_active_admin_user!
    authenticate_user! 
    unless current_user.admin?
      flash[:alert] = "Unauthorized Access!"
      redirect_to root_path 
    end
  end


  before_filter :redirect_to_teaser
  
  private
  
  # Prior to site availability, redirect users in production env to teaser:
  def redirect_to_teaser
    if Rails.env.production?
      logger.info "Redirecting user to WOSoMP Teaser"
      render :file=>File.join(Rails.root,"public/teaser.html"), :layout=>nil
      return
    end
  end
    
end
