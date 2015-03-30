require 'skipit_publisher'
SkipitPublisher::PublisherAPN.configure do |config|
  config.ios_app_name = 'skipit_ios'
  config.certificate_path = 'config/cert/skipit_dev.pem'
  config.environment = :sandbox
end

uri = nil
if ENV["REDISCLOUD_URL"]
  uri = ENV["REDISCLOUD_URL"]
else
  uri = 'redis://localhost:6379/'
end

SkipitPublisher::PublisherFaye.configure do |config|
  config.redis_uri = uri
  config.channel_name = 'publisher'
end