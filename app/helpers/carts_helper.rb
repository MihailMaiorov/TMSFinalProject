module CartsHelper
  def products
    @products ||= current_items.includes(:product).all
  end
end
