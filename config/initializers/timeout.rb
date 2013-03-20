# WOSOMP
# Rack Server Timeout Config

if Rails.env.production?
  Rack::Timeout.timeout = 10  # seconds
end
