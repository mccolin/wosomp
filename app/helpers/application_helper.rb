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
      opts = opts.merge(logout_opts).merge(:method=>:delete, :title=>current_user.name)
      link_to(raw("<i class='icon-user icon-white'></i> #{current_user.name}"), destroy_user_session_path, opts)
    else
      opts = opts.merge(login_opts).merge(:title=>"Login or Register")
      # link_to(raw("<i class='icon-user icon-white'></i> Login with Facebook"), new_user_session_path, opts)
      link_to(raw("<i class='icon-user icon-white'></i> Login or Register"), user_omniauth_authorize_path(:facebook), opts)
    end
  end

  # Render a top navigation link with properly active/feature classes:
  def top_nav_item(link_text, link_opts, html_opts={})
    css_class = html_opts[:class] || ""
    css_class = (css_class.split(/\s+/)+["active"]).join(" ") if current_page?(link_opts)
    html_opts[:class] = css_class
    content_tag :li, html_opts do
      link_to(link_text, link_opts)
    end
  end

  # Render the flash properly
  def render_flash
    flash[:error] ||= flash[:alert]
    flash[:info] ||= flash[:notice]
    if flash_message = flash[:error] || flash[:success] || flash[:info]
      flash_class = flash[:error] || flash[:alert] ? "alert-error" : (flash[:success] ? "alert-success" : "alert-info")
      flash_title = flash[:error] || flash[:alert] ? "Error!" : (flash[:success] ? "Hooray!" : "Note:")
      content_tag(:div, :class=>"alert #{flash_class}") do
        content_tag(:a, "x", :class=>"close", "data-dismiss"=>"alert") +
        content_tag(:strong, flash_title) + " " +
        flash_message
      end
    end
  end


  # Render the image for a sport; fallback to default image:
  def sport_image(sport, html_opts={})
    !sport.image.blank? ? image_tag("sports/#{sport.image}", html_opts) : image_tag("sports/default.png", html_opts)
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
