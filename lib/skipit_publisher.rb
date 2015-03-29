require 'rpush'
require 'skipit_publisher/engine'
require 'skipit_publisher/publisher_base'
Dir["#{File.dirname(__FILE__)}/skipit_publisher/publishers/**/*.rb"].each { |f| require f }
require 'skipit_publisher/publisher'

module SkipitPublisher
end
