# WOSoMP
#

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
  # Handle a user's post-authorize callback from Facebook:
  def facebook
    logger.debug "AUTH RESPONSE: #{request.env["omniauth.auth"].inspect}"
    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)
    if @user.persisted?
      flash[:success] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end
end
