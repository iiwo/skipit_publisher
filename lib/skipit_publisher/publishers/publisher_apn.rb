module SkipitPublisher
  class PublisherAPN < SkipitPublisher::PublisherBase

    cattr_accessor :ios_app_name
    cattr_accessor :certificate_path
    cattr_accessor :environment
    cattr_accessor :client

    class << self

      def publish(identifier, message, data, options={})
        notification = Rpush::Apns::Notification.new
        notification.app = self.client
        notification.device_token = identifier
        notification.alert = message
        notification.data = data
        notification.save!
      end

      def name
        :ios
      end

      def client
        @@client || initialize_client
      end

      def initialize_client
        Rpush::Apns::App.find_by_name(SkipitPublisher::PublisherAPN.ios_app_name) || create_app
      end

      def create_app
        app = Rpush::Apns::App.new
        app.name = SkipitPublisher::PublisherAPN.ios_app_name
        app.certificate = File.read(SkipitPublisher::PublisherAPN.certificate_path)
        app.environment = SkipitPublisher::PublisherAPN.environment
        app.connections = 1
        app.save!
        app
      end

    end

  end
end
