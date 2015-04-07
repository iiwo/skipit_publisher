module SkipitPublisher
  class PublisherMailer < ApplicationMailer

    def publisher_email(app_name, message, from, to, subject, data)
      @app_name = app_name
      @message = message
      @data = data
      mail from: from, to: to, subject: subject
    end

  end
end
