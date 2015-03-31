module SkipitPublisher
  class Publisher

    PUBLISHERS = [SkipitPublisher::PublisherAPN, SkipitPublisher::PublisherFaye]

    class << self

      # Broadcast message to requested publishers ( among registered ones ) identified by name
      #
      # example usage:
      #    publish('skipit_client', this is a test message',
      #            { :ios => 'af826ab01bfc170b7ffd967da099aff5e52a56a79e6209fcfbf6d8803acbc986',
      #              :faye =>'user_af826ab01'},
      #            { user_id: 4 }
      #    )
      def publish(app_name, message, identifiers, data = {}, options={})
        target_publishers = PUBLISHERS.select{ |p| identifiers[p.name].present? || identifiers[p.name.to_s].present? }
        target_publishers.each do |publisher|
          app = publisher.apps.select{|a| a[:name].to_s == app_name.to_s}.first
          if app.present?
            identifier = identifiers[publisher.name] || identifiers[publisher.name.to_s]
            publisher.publish(app, identifier, message, data, options)
          end
        end
      end

    end

  end
end