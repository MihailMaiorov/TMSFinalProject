class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @review = @user.reviews.build
    @reviews = @user.reviews.active.includes(:user).order updated_at: :desc
  end
end
