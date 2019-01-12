require 'will_paginate/array'

class PagedArray
  delegate_missing_to :@paged_collection

  def initialize(collection, page: 1, per_page: 20)
    @paged_collection = collection.paginate(
      page: page,
      per_page: per_page
    )
  end
end
