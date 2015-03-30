module SkipitPublisher
  class PublisherFaye < SkipitPublisher::PublisherBase

    cattr_accessor :redis_uri
    cattr_accessor :channel_name
    cattr_accessor :client

    class << self

      def publish(identifier, message, data, options={})
        message = {channel: "/#{identifier}", message: message, data: data}.to_json
        client.publish(SkipitPublisher::PublisherFaye.channel_name, message)
      end

      def name
        :faye
      end

      def client
        @@client || initialize_client
      end

      def initialize_client
        @@client = Redis.new(url: SkipitPublisher::PublisherFaye.redis_uri)
      end

    end

  end
end
