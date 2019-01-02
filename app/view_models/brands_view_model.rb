class BrandsViewModel < ApplicationViewModel
  def active_products_brand(brand)
    ProductDecorator.decorate_collection(brand.object.products.active)
  end
end
