# WOSoMP
# Gem Dependencies

source "https://rubygems.org"

# Lock in language and platform:
ruby "1.9.3"
gem "rails", "3.2.11"

# System Updates:
gem "json", ">=1.7.7"                 # Version force for CVE-2013-0269

# App Features:
gem "devise", "~> 2.0.4"
gem "omniauth-facebook", "~> 1.2.0"
gem "activeadmin"
#gem "sass-rails"
gem "meta_search", ">= 1.1.0.pre"
gem "stringex", "~> 1.3.2"
gem "slugged"
#gem "doeskeyvalue"
#gem "doeskeyvalue", :path=>"/Users/colin/git/awexome/doeskeyvalue"
#gem "awesome_print"
gem "less-rails"                      # Bootstrap Asset Pipeline LESS Support
gem "twitter-bootstrap-rails"         # Twitter Bootstrap
gem "jquery-rails"
gem "has_heartbeat", "~> 0.1.1"       # Heartbeat for uptime monitoring
gem "newrelic_rpm"                    # New Relic perf and uptime pinging

group :assets do
  gem "sass-rails",   "~> 3.2.3"
  gem "coffee-rails", "~> 3.2.1"
  gem "uglifier", ">= 1.0.3"
  gem "therubyracer"
end

group :development do
  gem "mysql2"
  gem "quiet_assets"
end

group :production, :staging do
  gem "pg"
  gem "unicorn"                       # Unicorn concurrent rack web server
  gem "dalli"                         # Dalli Memcached library
  gem "rack-timeout"                  # Timeout/abort mgmt for rack processes
end
