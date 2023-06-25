class CategoriesController < ApplicationController
  before_action :set_category, only: %i[edit show]

  def index
    @categories = Category.all
  end

  def show
    @product = @category.products.build
    @products = @category.products.order(updated_at: :desc)
  end
end

private

def set_category
  @category = Category.find(params[:id])
end
