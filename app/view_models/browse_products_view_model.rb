class BrowseProductsViewModel < ApplicationViewModel
  def products
    @products ||= begin
      products = BrowseProductsFinder.new(options).perform
      products = ProductViewModel.wrap(products)

      PagedArray.new(
        products,
        page: options[:page],
        per_page: Rails.configuration.browse_products_per_page
      )
    end
  end
end
