module SkipitPublisher
  class PublisherEmail < SkipitPublisher::PublisherBase

    cattr_accessor :apps

    class << self

      def publish(app, identifier, message, data, options={})
        raise 'Invalid configuration' unless valid?(app)
        SkipitPublisher::PublisherMailer.delay.publisher_email(app, message, app[:from], identifier, app[:subject], data)
      end

      def name
        :email
      end

      def valid?(app)
        app.present? && app[:name].present? && app[:from].present? && app[:subject].present?
      end

    end

  end
end
