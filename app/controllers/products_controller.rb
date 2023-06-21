class ProductsController < ApplicationController
  before_action :set_category
  before_action :set_product, except: %i[create new]
  before_action :authenticate_user!, only: %i[edit create update new destroy]

  def index
    @products = Product.all
  end

  def show; end

  def new
    @product = Product.new
  end

  def edit; end

  def create
    @product = @category.products.build(product_create_params)

    if @product.save
      redirect_to category_path(@category), notice: 'Product was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @product.update(product_params)
      redirect_to category_path(@category), notice: 'Product was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy

    redirect_to category_path(@category), notice: 'Product was successfully destroyed.'
  end

  private

  def set_category
    @category = Category.find(params[:category_id])
  end

  def set_product
    @product = @category.products.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, pictures: [])
  end

  def product_create_params
    product_params.merge(user_id: current_user.id)
  end
end
