# frozen_string_literal: true

module Products
  class Search
    class << self
      def call(category_title:, query:)
        if category_title.blank?
          result = Product.in_stock.ransack(query)
        else
          category_id = Category.find_by(title: category_title).id
          result = Product.in_stock.where(category_id: category_id).ransack(query)
        end

        products = result.result.includes(:category)

        [result, products]
      end
    end
  end
end
