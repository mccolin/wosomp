# WOSOMP
# PostOffice -- Mailer

class PostOffice < ActionMailer::Base

  # Prep our robot as the primary sender:
  default from: "wosomp@wosomp.com", subject: "WOSoMP"

  # Send our emails in the mailer layout:
  layout "post_office"

  # Registration Successful:
  def registered_email(registration)
    @registration ||= registration
    @user = @registration.user
    @olympiad = @registration.olympiad

    o_name = @olympiad.name
    o_date = @olympiad.begins_at.strftime("%B %0d")

    mail(:to => @user.email, :subject => "You Registered for WOSoMP #{o_name} on #{o_date}")
  end

end
