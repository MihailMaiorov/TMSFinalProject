# frozen_string_literal: true

module Reviews
  module Notification
    class EmailMailer < ApplicationMailer
      def new_review(reviewable_owner, review, user)
        @review = review
        @user = user
        @reviewable_owner = reviewable_owner

        mail(to: @reviewable_owner.email, subject: 'You have new review')
      end
    end
  end
end
