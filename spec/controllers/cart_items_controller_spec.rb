require 'rails_helper'

describe CartItemsController, type: :request do
  let!(:user) { create :user }
  let!(:category) { create :category }
  let!(:product) { create :product }
  let!(:cart) { create :cart, user: user }
  let!(:cart_item) { create :cart_item, cart: cart, product: product }
  let(:create_params) { { quantity: 1, product_id: product.id } }

  before do
    sign_in(user)
  end

  describe 'POST #create' do
    subject { post cart_cart_items_path(cart_id: cart.id), params: create_params }

    context 'with valid attributes' do
      it 'saves the new items in the table cart_items' do
        expect { subject }.to change(user.cart.cart_items, :count).by(1)
      end

      it 'redirect to show view' do
        expect(subject).to redirect_to(product_path(id: product.id))
      end
    end

    context 'with invalid attributes' do
      let(:create_params) { { quantity: 0, product_id: product.id } }

      it 'does not save the items' do
        expect { subject }.to_not change(user.cart.cart_items, :count)
      end
    end

    context 'if user dont sign in' do
      it 'does not save the items' do
        subject { post cart_cart_items_path(cart_id: cart.id), params: create_params }
        sign_out(user)

        expect { subject }.to_not change(user.cart.cart_items, :count)
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:create_params) { { id: cart_item.id, product_id: product.id } }

    subject { delete cart_cart_item_path(id: cart_item.id, cart_id: cart.id), params: create_params }

    it 'delete product from item' do
      expect { subject }.to change(user.cart.cart_items, :count).by(-1)
    end
  end

  it 'get all products in cart' do
    expect(cart.cart_items.includes(:product).all).to include(have_attributes(product_id: product.id))
  end
end
