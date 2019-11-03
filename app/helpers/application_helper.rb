module ApplicationHelper
  include ActionView::Helpers::AssetTagHelper

  def page_title
    @page_title.presence || 'There is more than Soylent — Complete Food'
  end

  def humanize_boolean(boolean)
    I18n.t((!!boolean).to_s)
  end

  def digest(cache_key)
    Digest::MD5.hexdigest(cache_key)
  end

  def render_flash_messages
    flash.map do |type, message|
      render_message(type, message)
    end.join("\n").html_safe
  end

  def render_message(type, message)
      message = capture(&block) if block_given?
      render('shared/message', type: type.to_sym, message: message)
  end
end
