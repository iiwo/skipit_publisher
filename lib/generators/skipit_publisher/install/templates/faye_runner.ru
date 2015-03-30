require 'rubygems'
require 'faye'
require 'em-hiredis'
require 'json'
require 'rails'
require 'skipit_publisher'
require ::File.join( ::File.dirname(__FILE__), 'config/initializers/skipit_publisher.rb')

@logger = Logger.new('log/publisher.log')
use Rack::CommonLogger, @logger

class SkipitPublisher::ActivityMonitor
  def incoming(message, callback)
    puts("incoming message: #{message}")
    callback.call(message)
  end
  def outgoing(message, callback)
    puts("outgoing message: #{message}")
    callback.call(message)
  end
end

Faye::WebSocket.load_adapter('thin')
@faye_server = Faye::RackAdapter.new(:mount => '/faye', :timeout => 25)
@faye_server.add_extension(SkipitPublisher::ActivityMonitor.new)

EM.next_tick {
  @redis = EM::Hiredis.connect(SkipitPublisher::PublisherFaye.redis_uri)
  @subscriber = @redis.pubsub
  @subscriber.subscribe(SkipitPublisher::PublisherFaye.channel_name)
  @subscriber.on(:message) do |topic, message|
    message = JSON.parse(message)
    @logger.info "redis channel: #{message['channel']} message: #{message['message']}"
    client = @faye_server.get_client
    client.publish message['channel'], message['message']
  end
}

run @faye_server
