class ApplicationController < ActionController::Base
  include Internationalization
  include Pundit::Authorization

  EMPTY_CART = 0

  rescue_from Pundit::NotAuthorizedError do |_e|
    render json: { message: 'No access' }, status: 403
  end

  rescue_from Pundit::NotDefinedError do |_e|
    render json: { message: 'Sing in only' }, status: 403
  end

  def current_items
    current_user.cart_items.includes(:product)
  end

  def current_items_total
    return EMPTY_CART if current_items.nil?

    current_items.sum(&:quantity)
  end

  helper_method :current_items, :current_items_total
end
