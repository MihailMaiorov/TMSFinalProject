# frozen_string_literal: true

module Users
  module Greetings
    class SendMailWorker
      include Sidekiq::Worker

      sidekiq_options queue: :mailers

      def perform(user_id)
        user = User.find(user_id)

        Users::Greetings::EmailMailer.greeting_mail(user).deliver_now
      end
    end
  end
end
