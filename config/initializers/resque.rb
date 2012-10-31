require 'resque/server'

ENV["REDISTOGO_URL"] ||= "redis://localhost:6379"
uri = URI.parse(ENV["REDISTOGO_URL"])
redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)

Resque.inline = true if Rails.env.test?
Resque.redis = redis

#hack for having resque reload classes in development
unless Rails.application.config.cache_classes
  Resque.after_fork do |job|
    ActionDispatch::Reloader.cleanup!
    ActionDispatch::Reloader.prepare!
  end
end