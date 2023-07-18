# frozen_string_literal: true

module Products
  class ReviewsController < ReviewsController
    before_action :set_reviewable

    private

    def set_reviewable
      @reviewable = Product.find(params[:product_id])
    end
  end
end
