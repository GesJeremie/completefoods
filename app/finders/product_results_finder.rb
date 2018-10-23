class ProductResultsFinder

  def initialize(params = {})
    @params = params
  end

  def execute
    products = active_products
    products = ProductMadeInFinder.new(products, @params).execute
    products = ProductFilterFinder.new(products, @params).execute
    products = ProductSortFinder.new(products, @params).execute
    products = ProductNarrowFinder.new(products, @params).execute

    unless sorting?
      products = products.reorder('name ASC')
    end

    products
  end


  private

    def active_products
      Product.includes( { brand: [:country] }, { price: [:currency] }, { image_attachment: [:blob] } ).active
    end

    def sorting?
      sort? || narrow?
    end

    def sort?
      @params[:sort].present? && @params[:sort] != 'nothing'
    end

    def narrow?
      @params[:narrow].present? && @params[:narrow] != 'nothing'
    end

end
