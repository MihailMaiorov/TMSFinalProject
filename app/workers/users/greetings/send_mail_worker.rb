# frozen_string_literal: true

module Users
  module Greetings
    class SendMailWorker
      include Sidekiq::Worker

      sidekiq_options queue: :mailers

      def perform(user_id)
        SendMail.call(user_id)
      end
    end
  end
end
