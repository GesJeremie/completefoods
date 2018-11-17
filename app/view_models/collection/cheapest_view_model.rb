class Collection::CheapestViewModel < CollectionViewModel
  def description
    [
      description_count_products_and_brands_referenced,
      description_top_fifteen('cheapest')
    ].join('<br/>')
  end
end
