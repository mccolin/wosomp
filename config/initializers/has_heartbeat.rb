# WOSoMP
# HasHeartbeat Configuration

HasHeartbeat.configure do |config|

  # Pump the DB once in awhile to stay alive on Heroku:
  config.check_model = User

end
