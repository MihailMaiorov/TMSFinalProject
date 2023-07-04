require 'rails_helper'

describe CartsController, type: :request do
  let!(:user) { create :user }
  let!(:category) { create :category }
  let!(:product) { create :product }
  let!(:cart) { create :cart, user: user }
  let!(:cart_item) { create :cart_item, cart: cart }

  describe 'GET #show' do
    it 'render show view' do
      sign_in(user)
      get cart_path(id: cart.id)
      expect(response.body).to include(product.name)
    end
  end

  describe 'DELETE #destroy' do
    subject { delete cart_path(id: cart.id) }

    context 'delete from cart' do
      it 'delete product from cart' do
        sign_in(user)

        expect { subject }.to change { user.reload.cart.present? }.to(false)
      end

      it 'delete product from cart_items' do
        sign_in(user)

        expect { subject }.to change(user.cart.cart_items, :count).by(-1)
      end

      it 'render view show after destroy' do
        get cart_path(id: cart.id)
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
