module CounterHelper
  def count_active_products
    Product.active.count
  end

  def count_brands
    Brand.count
  end
end
