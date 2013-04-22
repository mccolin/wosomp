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
      flash_title = flash[:error] || flash[:alert] ? "" : (flash[:success] ? "Hooray!" : "Note:")
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


  # Render an icon for an athlete registration:
  def reg_icon(reg, html_classes="")
    inner_html = ""
    tooltip_text = reg.user.name
    if reg.athlete?
      inner_html += content_tag(:span, reg.uniform_name, :class=>"name") + content_tag(:span, reg.uniform_number, :class=>"number")
      tooltip_text += reg.captain? ? " - Captain" : " - Athlete"
    else
      inner_html += content_tag(:span, "Fan", :class=>"name") + content_tag(:span, "#1", :class=>"number")
      tooltip_text += " - Supporter"
    end
    html_classes = ["athlete-icon", html_classes]
    html_classes << "shirt-#{reg.team.shirt_color}" if reg.team
    html_classes << "captain" if reg.captain?
    content_tag :div, inner_html.html_safe, "data-toggle"=>"tooltip", "data-placement"=>"bottom", :title=>tooltip_text, :class=>html_classes.join(" "), :style=>""
  end

  # Render a registration's shirt for display on confirmation:
  def reg_shirt(reg, opts={})
    c_width = opts[:width] || 300
    c_height = opts[:height] || 285
    r_name = opts[:name] || reg.uniform_name || "WOSoMP"
    r_number = opts[:number] || reg.uniform_number || DateTime.now.year - 2000
    r_shirt_image = if opts[:color]
      image_path("shirts/#{opts[:color]}.jpg")
    elsif reg.team && reg.team.shirt_color
      image_path("shirts/#{reg.team.shirt_color}.jpg")
    else
      image_path("shirts/gray.jpg")
    end
    html_classes = opts[:class] ? "shirt-preview #{opts[:class]}" : "shirt-preview"
    html_id = opts[:id] || "shirt-reg-#{reg.id}"

    content_tag(:canvas, "id"=>html_id, "class"=>html_classes, "width"=>c_width, "height"=>c_height, "data-shirt-preview"=>true, "data-shirt-name"=>r_name, "data-shirt-number"=>r_number, "data-shirt-image"=>r_shirt_image) do
      content_tag(:div, :id=>html_id, :class=>html_classes) do
        image_tag(r_shirt_image, :class=>"selected") +
        content_tag(:span, r_name, :class=>"name") +
        content_tag(:span, r_number, :class=>"number")
      end
    end
  end

  # Display a pre-saved image (if it exists) for a registration shirt:
  def reg_shirt_image(reg, opts={})
    src = reg.shirt_asset_path()
    image_tag src, opts
  end


  # Return the next/upcoming Olympiad:
  def featured_olympiad
    @featured_olympiad ||= Olympiad.featured_olympiad()
  end

  # Return the name of the next/upcoming Olympiad:
  def featured_olympiad_name
    featured_olympiad.name
  end


end
