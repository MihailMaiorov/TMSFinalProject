class ReviewsController < ApplicationController
  def edit
    @review = @reviewable.reviews.find(params[:id])

    authorize @review
  end

  def create
    @review = @reviewable.reviews.build(review_create_params)

    authorize @review

    if @review.save
      send_mail

      redirect_to polymorphic_url(@reviewable)
    else
      render 'pages/index', status: :unprocessable_entity
    end
  end

  def update
    @review = @reviewable.reviews.find(params[:id])

    authorize @review

    if @review.update(review_update_params)
      redirect_to polymorphic_url(@reviewable), notice: t('.success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def archive
    @review = @reviewable.reviews.find(params[:id])

    authorize @review

    @review.update!(archived: true)

    redirect_to polymorphic_url(@reviewable), notice: t('.success')
  end

  private

  def set_review
    @review = @reviewable.reviews.find(params[:id])
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
