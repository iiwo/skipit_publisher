class SkipitPublisher::InstallGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  desc 'Copy initializer'
  def copy_initializer
    template 'skipit_publisher.rb', 'config/initializers/skipit_publisher.rb'
  end

  desc 'Copy faye runner'
  def copy_faye_runner
    template 'faye_runner.ru', 'faye_runner.ru'
  end

end
