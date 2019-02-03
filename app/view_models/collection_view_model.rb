class CollectionViewModel < ApplicationViewModel
  def description
    @description ||= CollectionDescription.new(model).perform
  end

  def image
    "collections/#{model.cover}"
  end
end
