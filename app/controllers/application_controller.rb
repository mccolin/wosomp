class ApplicationController < ActionController::Base

  protect_from_forgery


  # Authentication for Admin Super Users:
  def authenticate_active_admin_user!
    authenticate_user!
    unless current_user.admin?
      flash[:alert] = "Sorry, you do not have access to Administrative area."
      redirect_to home_path
    end
  end



  private

  # Prior to site availability, redirect users in production env to teaser:
  def redirect_to_teaser
    if Rails.env.production?
    # if user_signed_in? && current_user.admin?
    #   logger.info "User is a logged-in Admin user. Displaying page."
    # else
      logger.info "User is not authorized. Redirecting user to WOSoMP Teaser"
      render :file=>File.join(Rails.root,"public/teaser.html"), :layout=>nil
      return
    end
  end

end
