# frozen_string_literal: true

class CartItemsController < ApplicationController
  include CartItemsHelper
  before_action :product, only: :create

  def create
    current_user.cart_items.create(item_params)
    redirect_to product_path(@product)
  end

  def destroy
    current_items.find(params[:id]).destroy
    render 'cart_items/show', status: :unprocessable_entity
  end

  private

  def item_params
    params.permit(:product_id, :quantity)
  end

  def product
    @product = Product.find(params[:product_id])
  end
end
