class Collection::AthletesViewModel < CollectionViewModel
  def description
    [
      description_count_products_and_brands_referenced,
      description_top_fifteen
    ].join('<br/>')
  end

  def description_top_fifteen
    "This is the <strong>Top 15</strong> of the soylent alternatives for athletes available on the market"
  end
end
