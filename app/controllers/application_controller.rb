class ApplicationController < ActionController::Base
  include Internationalization

  EMPTY_CART = 0

  def current_cart
    @current_cart ||= Cart.find_or_create_by(user: current_user)
  end

  def current_items
    current_cart.cart_items.includes(:product)
  end

  def cart_total
    return EMPTY_CART if current_items.nil?

    current_items.sum(&:quantity)
  end

  helper_method :current_cart, :current_items, :cart_total
end
