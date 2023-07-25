require 'rails_helper'

RSpec.describe Users::Greetings::EmailMailer do
  describe '#greeting_mail' do
    let!(:user) { create :user }
    let(:mail) { Users::Greetings::EmailMailer.greeting_mail(user) }

    it 'renders the subject' do
      expect(mail.subject).to eql('You have successfully registered!')
    end

    it 'renders the receiver email' do
      expect(mail.to).to eql([user.email])
    end

    it 'renders the sender email' do
      expect(mail.from).to eql(['MarketPlace@gmail.com'])
    end

    it 'contains user email' do
      expect(mail.body.encoded).to match(user.email)
    end
  end
end
