class CollectionViewModel < ApplicationViewModel
  def description
    nil
  end

  def image
    "collections/#{model.cover}"
  end
end
