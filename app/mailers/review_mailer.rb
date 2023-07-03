class ReviewMailer < ApplicationMailer
  include Sidekiq::Worker

  sidekiq_options queue: :reviews

  def perform(user, review)
    @review = review
    @user = user

    mail(to: @user.email, subject: 'New review')
  end
end
