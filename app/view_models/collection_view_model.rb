class CollectionViewModel < ApplicationViewModel

  def initialize(products, current_currency:)
    @products = products
    @current_currency = current_currency
  end

  def description
    [
      description_products_count,
      description_products_names,
      description_average_price,
      description_produced_by_brands_count,
    ].compact.join(' ') << '.'
  end

  def meta_description
    description_without_html_entities
  end

  protected

    def description_products_count
      return "There are over #{@products.count} products" if @products.count > 1
      return 'Sadly ... there is currently only one product' if @products.count == 1

      'Ooops ... there is currently no products'
    end

    def description_products_names
      return if @products.count < 5

      "like #{@products.first.name.titleize}, #{@products.second.name.titleize} and #{@products.third.name.titleize}"
    end

    def description_average_price
      return if @products.count < 2

      "with an average price of #{from_usd_to_current_currency(average_price_products)} per month based on a 2,000 calorie daily diet"
    end

    def description_produced_by_brands_count
      return if @products.count < 2

      "and produced by a total of #{brands_count} brands"
    end

    def description_top_fifteen(type)
      "This is the <strong>Top 15</strong> of the <strong>#{type} soylent alternatives</strong> available on the market"
    end

    def description_count_products_and_brands_referenced
      "We currently reference <strong>#{Product.active.count} products</strong> from <strong>#{Brand.count} brands</strong>."
    end

    def description_without_html_entities
      ActionView::Base.full_sanitizer.sanitize(description)
    end

    def brands_count
      @brands_count ||= @products.group_by(&:brand_id).count
    end

    def price(product)
      product.price.per_month_bulk_order_in_currency('USD')
    end

    def price_formatted(product)
      price = price(product)
      from_usd_to_current_currency(price)
    end

    def from_usd_to_current_currency(number)
      to_currency = number.to_money('USD').exchange_to(@current_currency.code).to_f
      to_currency_decimal = sprintf('%.2f', to_currency)

      "#{@current_currency.symbol}#{to_currency_decimal}"
    end

    def average_price_products
      prices = @products.map(&method(:price))

      prices.sum / prices.size.to_f
    end
end
