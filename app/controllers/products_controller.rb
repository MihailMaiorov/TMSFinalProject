class ProductsController < ApplicationController
  before_action :set_product, except: %i[create new index]
  before_action :authenticate_user!, only: %i[edit create update new destroy]

  def index
    if params[:category].blank?
      @products = Product.all
    else
      @category_id = Category.find_by(title: params[:category]).id
      @products = Product.where(category_id: @category_id).order(updated_at: :desc)
    end
  end

  def show; end

  def new
    @product = current_user.products.build
    @categories = Category.all.map { |c| [c.title, c.id] }
  end

  def edit
    @categories = Category.all.map { |c| [c.title, c.id] }
  end

  def create
    @product = current_user.products.build(product_params)
    @product.category_id = params[:category_id]

    if @product.save
      redirect_to categories_path, notice: t('.success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @product.category_id = params[:category_id]

    if @product.update(product_params)
      redirect_to product_path(@product), notice: t('.success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy

    redirect_to categories_path, notice: t('.success')
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :user_id, :price, :category_id, pictures: [])
  end
end
