# frozen_string_literal: true

module Products
  class Search
    class << self
      def call(category_title:, q:)
        if category_title.blank?
          @q = Product.in_stock.ransack(q)
        else
          @category_id = Category.find_by(title: category_title).id
          @q = Product.in_stock.where(category_id: @category_id).ransack(q)
        end

        @products = @q.result.includes(:category)

        [@q, @products]
      end
    end
  end
end
