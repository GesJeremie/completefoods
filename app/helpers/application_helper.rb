module ApplicationHelper
  include ActionView::Helpers::AssetTagHelper

  def humanize_boolean(boolean)
    I18n.t((!!boolean).to_s)
  end

  def icon_boolean(boolean)
    boolean ? inline_svg('check.svg', class: 'icon') : inline_svg('cross.svg', class: 'icon')
  end

  def strikethrough_if_false(text, boolean)
    boolean ? text : content_tag(:strike, text)
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
end
