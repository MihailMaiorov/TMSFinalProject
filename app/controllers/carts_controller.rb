class CartsController < ApplicationController
  def show
    @products ||= current_items.joins(:product).all

  end

  def destroy
    current_cart.destroy

    render :show
  end

  def products
    # binding.pry
  end
end
