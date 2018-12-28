module ApplicationHelper
  include ActionView::Helpers::AssetTagHelper

  def digest_for_cache(value)
    Digest::MD5.hexdigest(value.to_s)
  end

  def params_for_cache
    params.permit!.to_h
  end

  def humanize_boolean(boolean)
    I18n.t((!!boolean).to_s)
  end

  def to_slug(string)
    string.parameterize.truncate(80, omission: '')
  end

  def dashboard_flash_class(type)
    case type.to_sym
      when :notice  then 'alert alert-info'
      when :success then 'alert alert-success'
      when :error   then 'alert alert-error'
      when :alert   then 'alert alert-error'
    end
  end

  def emoji(name)
    image_tag "emojis/#{name}.png", class: "emoji emoji--#{name}"
  end

  def preview_collections
    Rails.configuration.collections.slice(0, 8)
  end

  def preview_brands
    brands = Brand.reorder(name: :asc).slice(0, 16)
    BrandDecorator.decorate_collection(brands)
  end
end
