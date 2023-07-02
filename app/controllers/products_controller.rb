class ProductsController < ApplicationController
  before_action :set_product, only: %i[edit update show destroy change_status]
  before_action :set_categories, only: %i[new edit create]
  before_action :authenticate_user!, only: %i[edit create update new destroy]

  def index
    if params[:category].blank?
      @products = Product.in_stock.order(updated_at: :desc)
    else
      @category_id = Category.find_by(title: params[:category]).id
      @products = Product.in_stock.where(category_id: @category_id).order(updated_at: :desc)
    end
  end

  def show
    @review = @product.reviews.build
    @reviews = @product.reviews.active.includes(:user).order updated_at: :desc
  end

  def new
    @product = current_user.products.build
  end

  def edit
    authorize @product
  end

  def create
    @product = current_user.products.build(product_create_params)

    authorize @product

    if @product.save
      redirect_to product_path(@product), notice: t('.success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @product.update(product_update_params)
      redirect_to product_path(@product), notice: t('.success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def change_status
    authorize @product

    @product.update!(status: 'out of stock')

    redirect_to products_path, notice: t('.success')
  end

  private

  def set_categories
    @categories = Category.all.map { |c| [c.title, c.id] }
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def product_create_params
    params.require(:product).permit(:name, :description, :user_id, :price, pictures: []).merge(category_id: params[:category_id])
  end

  def product_update_params
    params.require(:product).permit(:name, :description, :user_id, :price, pictures: [])
  end
end
