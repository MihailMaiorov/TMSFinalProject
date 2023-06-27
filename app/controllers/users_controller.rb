class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @review = @user.reviews.build
    @reviews = @user.reviews.order created_at: :desc
  end
end
