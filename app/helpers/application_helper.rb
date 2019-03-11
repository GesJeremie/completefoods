module ApplicationHelper
  include ActionView::Helpers::AssetTagHelper

  def page_title
    return @page_title.presence || 'There is more than Soylent — Complete Food'
  end

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

  def leading_zero(number)
    number.to_s.rjust(2, '0')
  end

  def dashboard_flash_class(type)
    case type.to_sym
      when :notice  then 'alert alert-info'
      when :success then 'alert alert-success'
      when :error   then 'alert alert-error'
      when :alert   then 'alert alert-error'
    end
  end
end
