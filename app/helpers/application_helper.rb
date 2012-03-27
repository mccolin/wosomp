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
      link_to(raw("<i class='icon-user icon-white'></i> Logout"), destroy_user_session_path, opts)
    else
      opts.merge!(login_opts)
      # link_to("Login", new_user_session_path, opts)      
      link_to(raw("<i class='icon-user icon-white'></i> Login with Facebook"), user_omniauth_authorize_path(:facebook), opts)
    end
  end
  
  # Set the active top navigation
  def set_active_nav(nav_id="home")
    content_for :javascripts do
      content_tag(:script, :type=>"text/javascript") do
        raw """ 
          $(function(){ 
            $('#top-nav li').removeClass('active');
            $('#top-nav li#link-#{nav_id}').addClass('active');
          }); 
        """
      end
    end
  end
  
  # Render the flash properly
  def render_flash
    if flash_message = flash[:error] || flash[:success] || flash[:info]
      flash_class = flash[:error] ? "alert-error" : (flash[:success] ? "alert-success" : "alert-info")
      flash_title = flash[:error] ? "Error!" : (flash[:success] ? "Hooray!" : "Yo! Check it:")
      content_tag(:div, :class=>"alert #{flash_class}") do
        content_tag(:a, "x", :class=>"close", "data-dismiss"=>"alert") +
        content_tag(:strong, flash_title) + " " +
        flash_message
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
