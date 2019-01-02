class Products::ShowViewModel
  attr_reader :product, :brand, :reviews

  def initialize(product:)
    product = product.decorate

    @brand = product.brand
    @reviews = product.reviews
    @product = product
  end

  def meta_title
  end

  def meta_description
  end

  def meta_image
  end

end
