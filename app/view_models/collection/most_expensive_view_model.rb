class Collection::MostExpensiveViewModel < CollectionViewModel
  def description
    [
      description_count_products_and_brands_referenced,
      description_top_fifteen('most expensive')
    ].join('<br/>')
  end
end
