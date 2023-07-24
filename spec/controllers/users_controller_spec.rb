# frozen_string_literal: true

require 'rails_helper'

describe UsersController, type: :request do
  let!(:user) { create :user }
  let!(:category) { create :category }
  let!(:product) { create :product }
  let!(:cart_item) { create :cart_item, user: user }

  before do
    sign_in(user)
  end

  describe 'GET #show' do
    it 'render show view' do
      get cart_item_path(id: cart_item.id)
      expect(response.body).to include(product.name)
    end
  end

  describe 'DELETE #destroy' do
    subject { delete cart_item_path(id: cart_item.id) }

    context 'delete from cart' do
      it 'delete product from cart' do
        expect { subject }.to change { user.reload.cart_items.present? }.to(false)
      end

      it 'delete product from cart_items' do
        expect { subject }.to change(user.cart_items, :count).by(-1)
      end

      it 'render view show after destroy' do
        get cart_item_path(id: cart_item.id)
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
