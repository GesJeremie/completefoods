class ImageUploadValidator < ActiveModel::EachValidator

  ALLOWED_TYPES = %w[image/png image/jpeg].freeze

  def validate_each(record, attribute, image)
    unless image.attached?
      return record.errors.add(attribute, 'is required')
    end

    unless image.attachment.blob.content_type.in?(ALLOWED_TYPES)
      image.purge
      record.errors.add(attribute, 'must be an image file')
    end
  end
end
