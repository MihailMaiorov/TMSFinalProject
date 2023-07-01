class ReviewsController < ApplicationController
  before_action :set_reviewable
  before_action :set_review, only: %i[edit update archive]

  def edit; end

  def create
    @review = @reviewable.reviews.build(review_params)

    if @review.save
      redirect_to polymorphic_url(@reviewable)
    else
      render 'pages/index', status: :unprocessable_entity
    end
  end

  def update
    if @review.update(review_params)
      redirect_to polymorphic_url(@reviewable), notice: t('.success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def archive
    @review.update!(archived: true)

    redirect_to polymorphic_url(@reviewable), notice: t('.success')
  end

  private

  def set_review
    @review = @reviewable.reviews.find(params[:id])
  end

  def set_reviewable
    return @reviewable = Product.find(params[:product_id]) if params[:product_id]

    @reviewable = User.find(params[:user_id]) if params[:user_id]
  end

  def review_params
    params.require(:review).permit(:rating, :comment, :reviewable_type, :reviewable_id).merge(user_id: current_user.id)
  end
end
