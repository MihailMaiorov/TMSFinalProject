module Users
  module Greetings
    class EmailMailer < ApplicationMailer
      def greeting_mail(user)
        @user = user

        mail(to: @user.email, subject: 'You have successfully registered!')
      end
    end
  end
end
