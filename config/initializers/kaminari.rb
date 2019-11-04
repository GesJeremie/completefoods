#
# Fix conflict between will_paginate (application pagination)
# and Kaminari (admin pagination).
#
# TODO: Use kaminari by default.
#
if defined?(WillPaginate)
  module WillPaginate
    module ActiveRecord
      module RelationMethods
        def per(value = nil) per_page(value) end
        def total_count() count end
      end
    end
    module CollectionMethods
      alias_method :num_pages, :total_pages
    end
  end
end
