module SkipitPublisher
  class PublisherBase

    def initialize
      yield self if block_given?
    end

    class << self

      def name
        :ios
      end

      def configure
        yield self
      end

    end

  end
end