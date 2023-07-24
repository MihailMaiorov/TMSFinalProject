# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'MarketPlace@gmail.com'
  layout 'mailer'
end
