module SkipitPublisher
  class Publisher

    PUBLISHERS = [SkipitPublisher::PublisherAPN]

    class << self

      # Broadcast message to requested publishers ( among registered ones ) identified by name
      #
      # example usage:
      #    publish('this is a test message',
      #            { :ios => 'af826ab01bfc170b7ffd967da099aff5e52a56a79e6209fcfbf6d8803acbc986',
      #              :faye =>'user_af826ab01'},
      #            { user_id: 4 }
      #    )
      def publish(message, identifiers, data = {}, options={})
        target_publishers = PUBLISHERS.select{ |p| identifiers[p.name].present? || identifiers[p.name.to_s].present? }
        target_publishers.each do |publisher|
          identifier = identifiers[publisher.name] || identifiers[publisher.name.to_s]
          publisher.publish(identifier, message, data, options={})
        end
      end

    end

  end
end