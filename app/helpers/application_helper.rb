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
    if user_signed_in?
      link_to("Logout", destroy_user_session_path, opts.merge(:method => :delete))
    else
      link_to("Login", new_user_session_path, opts)
    end
  end
  
  
end
