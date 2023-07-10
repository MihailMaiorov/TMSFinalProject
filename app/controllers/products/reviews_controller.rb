class Products::ReviewsController < ReviewsController
  before_action :set_reviewable

  private

  def set_reviewable
    @reviewable = Product.find(params[:product_id])
  end
end
