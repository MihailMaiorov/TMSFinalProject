# frozen_string_literal: true

require 'rails_helper'

describe User, type: :model do
  let!(:user) { create :user }
  let!(:user_role) { create :role }

  describe '#assign_default_role' do
    context 'when user role is nil' do
      it 'assigns default user role' do
        expect(user.roles.first.name).to eq(user_role.name)
      end

      it 'count of roles for user' do
        expect(user.roles.count).to eq(1)
      end
    end

    context 'when user role is present' do
      let!(:user) { create :user, :with_role }
      it 'asigns user role to seller' do
        expect(user.roles.map(&:name)).to eq(%w[user seller])
      end

      it 'count of roles for seller' do
        expect(user.roles.count).to eq(2)
      end
    end
  end
end
