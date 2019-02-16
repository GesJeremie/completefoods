module MetaTagsHelper
  def meta_title
    @meta_title ||= (content_for(:meta_title) || DEFAULT_META['title'])
  end

  def meta_description
    @meta_description ||= (content_for(:meta_description) || DEFAULT_META['description'])
  end

  def meta_image
    @meta_image ||= fetch_meta_image
  end

  private
    def fetch_meta_image
      meta_image = content_for(:meta_image) || DEFAULT_META['image']

      if meta_image.starts_with?('http')
        meta_image
      else
        image_url(meta_image)
      end
    end
end
