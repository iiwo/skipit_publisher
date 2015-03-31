module SkipitPublisher
  class PublisherAPN < SkipitPublisher::PublisherBase

    cattr_accessor :apps
    cattr_accessor :client

    class << self

      def publish(app, identifier, message, data, options={})
        raise 'Invalid configuration' unless valid?(app)
        notification = Rpush::Apns::Notification.new
        notification.app = self.client(app)
        notification.device_token = identifier
        notification.alert = message
        notification.data = data
        notification.save!
      end

      def name
        :ios
      end

      def client(app)
        initialize_client(app)
      end

      def initialize_client(app)
        Rpush::Apns::App.find_by_name(app[:name]) || create_app(app)
      end

      def create_app(app)
        rpush_app = Rpush::Apns::App.new
        rpush_app.name = app[:name]
        rpush_app.certificate = File.read(app[:certificate_path])
        rpush_app.environment = app[:environment]
        rpush_app.connections = 1
        rpush_app.save!
        rpush_app
      end

      def valid?(app)
        app.present? && app[:name].present? && app[:certificate_path].present? && app[:environment].present?
      end

    end

  end
end
