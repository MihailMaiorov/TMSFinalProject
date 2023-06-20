class ProductsController < ApplicationController
  before_action :set_category
  before_action :set_product, except: %i[create new]

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
    respond_to do |format|
      if @product.save
        format.html { redirect_to category_path(@category), notice: 'Product was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to category_path(@category), notice: 'Product was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @product.destroy

    respond_to do |format|
      format.html { redirect_to category_path(@category), notice: 'Product was successfully destroyed.' }
    end
  end

  private

  def set_category
    @category = Category.find(params[:category_id])
  end

  def set_product
    @product = @category.products.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price)
  end

  def product_create_params
    product_params.merge(user_id: current_user.id)
  end
end
