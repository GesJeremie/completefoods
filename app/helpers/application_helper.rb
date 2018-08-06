module ApplicationHelper
  include ActionView::Helpers::NumberHelper
  include ActionView::Helpers::AssetTagHelper

  def humanize_boolean(boolean)
    I18n.t((!!boolean).to_s)
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

end
