class UserMailer < ApplicationMailer
  include Sidekiq::Worker

  sidekiq_options queue: :users

  def perform(user)
    @user = user
    mail(to: @user.email, subject: 'You have successfully registered!')
  end
end
