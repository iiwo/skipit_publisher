require 'skipit_publisher'
SkipitPublisher::PublisherAPN.configure do |config|
  config.apps = [
      {
          name: 'skipit_client',
          certificate_path: 'config/cert/skipit_dev.pem',
          environment: :sandbox
      },
      {
          name: 'skipit_merchant',
          certificate_path: 'config/cert/skipit_dev.pem',
          environment: :sandbox
      }
  ]
end

uri = nil
if ENV["REDISCLOUD_URL"]
  uri = ENV["REDISCLOUD_URL"]
else
  uri = 'redis://localhost:6379/'
end

SkipitPublisher::PublisherFaye.configure do |config|
  config.redis_uri = uri
  config.apps = [
      {
          name: 'skipit_client',
          redis_channel: 'publisher'
      },
      {
          name: 'skipit_merchant',
          redis_channel: 'publisher'
      }
  ]
end