# frozen_string_literal: true

module CartItemsHelper
  def products
    @products ||= current_items.includes(:product).all
  end
end
