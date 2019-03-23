class BrowseCollectionsViewModel < ApplicationViewModel
  def cache_key
    ['collections', collections.size].join('/')
  end

  def collections
    @collections ||= begin
      CollectionViewModel.wrap(
        Collection.all,
        options
      )
    end
  end
end
