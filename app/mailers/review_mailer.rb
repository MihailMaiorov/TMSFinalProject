class ReviewMailer < ApplicationMailer
  include Sidekiq::Worker

  sidekiq_options queue: :reviews

  def perform(reviewable, review, user)
    @review = review
    @user = user
    @reviewable = reviewable

    mail(to: User.find(@reviewable.user_id).email, subject: 'You have new review')
  end
end
