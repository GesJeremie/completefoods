class CollectionViewModel < ApplicationViewModel
  def description
    @description ||= Description.new(model).perform
  end

  def image
    "collections/#{model.cover}"
  end
end
