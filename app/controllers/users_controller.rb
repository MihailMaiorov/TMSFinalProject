class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @review = @user.reviews.new
    @reviews = @user.reviews
  end
end
