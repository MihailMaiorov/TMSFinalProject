class CartsController < ApplicationController
  include CartsHelper

  def show; end

  def destroy
    current_cart.destroy

    render :show
  end
end
