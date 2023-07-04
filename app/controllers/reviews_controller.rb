class ReviewsController < ApplicationController
  before_action :set_reviewable
  before_action :set_review, only: %i[edit update archive]
  after_action :send_mail, only: :create

  def edit
    authorize @review
  end

  def create
    @review = @reviewable.reviews.build(review_create_params)

    authorize @review

    if @review.save
      redirect_to polymorphic_url(@reviewable)
    else
      render 'pages/index', status: :unprocessable_entity
    end
  end

  def update
    authorize @review

    if @review.update(review_update_params)
      redirect_to polymorphic_url(@reviewable), notice: t('.success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def archive
    authorize @review

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

  def review_update_params
    params.require(:review).permit(:rating, :comment)
  end

  def review_create_params
    params.require(:review).permit(:rating, :comment).merge(user_id: current_user.id)
  end

  def send_mail
    ReviewMailer.perform(@reviewable, @review, current_user).deliver_later
  end
end
