module ApplicationHelper
  
  # Render the login status
  def login_status(opts={})
    if user_signed_in?
      "Welcome, #{current_user.first_name}!"
    else
      "Not Logged In"
    end
  end
  
  # Render the appropriate link for session management:
  def login_logout_link(opts={})
    logout_opts = opts.delete(:logout) || {}
    login_opts = opts.delete(:login) || {}
    if user_signed_in?
      opts = opts.merge(logout_opts).merge(:method=>:delete)
      link_to("Logout", destroy_user_session_path, opts)
    else
      opts.merge!(login_opts)
      # link_to("Login", new_user_session_path, opts)      
      link_to("Login with Facebook", user_omniauth_authorize_path(:facebook), opts)
    end
  end
  
  
end
