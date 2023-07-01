module CartsHelper
  def products
    @products ||= current_items.joins(:product).all
  end
end
