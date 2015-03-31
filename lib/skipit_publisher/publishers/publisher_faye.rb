module SkipitPublisher
  class PublisherFaye < SkipitPublisher::PublisherBase

    cattr_accessor :redis_uri
    cattr_accessor :apps
    cattr_accessor :client

    class << self

      def publish(app, identifier, message, data, options={})
        raise 'Invalid configuration' unless valid?(app) && SkipitPublisher::PublisherFaye.redis_uri.present?
        message = {channel: "/#{identifier}", message: message, data: data, app: app[:name]}.to_json
        client.publish(app[:redis_channel], message)
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

      def valid?(app)
        app.present? && app[:name].present? && app[:redis_channel].present?
      end

    end

  end
end
