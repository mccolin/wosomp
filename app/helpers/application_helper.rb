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
  
  # Set the active top navigation
  def set_active_nav(nav_id="home")
    content_for :head do
      content_tag(:script, :type=>"text/javascript") do
        raw """ 
          $(function(){ 
            $('#top-nav ul li').removeClass('active');
            $('#top-nav ul li#link-#{nav_id}').addClass('active');
          }); 
        """
      end
    end
  end
  
  
  # Return the next/upcoming Olympiad:
  def next_olympiad
    @next_olympiad ||= Olympiad.next_olympiad()
  end
  
  # Return the name of the next/upcoming Olympiad:
  def next_olympiad_name
    next_olympiad.name
  end

  
end
