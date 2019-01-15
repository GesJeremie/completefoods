class CollectionViewModel < ApplicationViewModel
  def image
    "collections/#{model.cover}"
  end
end
