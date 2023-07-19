# frozen_string_literal: true

module Reviews
  module Notifications
    class SendMailWorker
      include Sidekiq::Worker

      sidekiq_options queue: :mailers

      def perform(reviewable_id, review_id, current_user_id)
        SendMail.call(reviewable_id, review_id, current_user_id)
      end
    end
  end
end
