Rails.application.routes.draw do

  mount SkipitPublisher::Engine => "/skipit_publisher"
end
