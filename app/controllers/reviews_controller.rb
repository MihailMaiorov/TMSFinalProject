class ReviewsController < ApplicationController
  def new
    @review = reviewable.reviews.build
  end

  def create
    @review = reviewable.reviews.build(review_params)

    if @review.save
      redirect_to products_path
    else
      render 'pages/index', status: :unprocessable_entity
    end
  end

  private

  def reviewable
    return Product.find params[:product_id] if params[:product_id]

    User.find params[:user_id] if params[:user_id]
  end

  def review_params
    params.require(:review).permit(:rating, :comment, :reviewable_type, :reviewable_id).merge(user_id: current_user.id)
  end
end
