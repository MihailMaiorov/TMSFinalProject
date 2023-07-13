module Reviews
  module Notification
    class SendMail
      class << self
        def call(reviewable_id, review_id, current_user_id)
          reviewable_owner = User.find(reviewable_id)
          review = Review.find(review_id)
          user = User.find(current_user_id)

          Reviews::Notification::EmailMailer.new_review(reviewable_owner, review, user).deliver_now
        end
      end
    end
  end
end
