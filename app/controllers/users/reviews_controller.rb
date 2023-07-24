# frozen_string_literal: true

module Users
  class ReviewsController < ReviewsController
    before_action :set_reviewable

    private

    def set_reviewable
      @reviewable = User.find(params[:user_id])
    end
  end
end
