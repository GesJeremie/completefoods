class CollectionViewModel < ApplicationViewModel

  def initialize(products:, current_currency:)
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

  protected

    def description_products_count
      return "There are over #{@products.count} soylent alternatives" if @products.count > 1
      return 'Sadly ... there is currently only one soylent alternative' if @products.count == 1

      'Ooops ... there is currently no soylent alternatives'
    end

    def description_products_names
      return if @products.count < 5

      "like #{@products.first.name}, #{@products.second.name} and #{@products.third.name}"
    end

    def description_average_price
      return if @products.count < 2

      "with an average price of #{from_usd_to_current_currency(average_price_products)} per month based on a 2,000 calorie daily diet"
    end

    def description_produced_by_brands_count
      return if @products.count < 2

      "and are produced by a total of #{brands_count} brands"
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
