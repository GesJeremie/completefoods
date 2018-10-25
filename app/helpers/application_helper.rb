module ApplicationHelper
  include ActionView::Helpers::NumberHelper
  include ActionView::Helpers::AssetTagHelper

  def digest_for_cache(value)
    Digest::MD5.hexdigest(value.to_s)
  end

  def params_for_cache
    params.permit!.to_h.except!(:controller, :action)
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

  def from_usd_to_current_currency(number)
    to_currency = number.to_money('USD').exchange_to(current_currency.code).to_f
    to_currency_decimal = sprintf('%.2f', to_currency)

    "#{current_currency.symbol}#{to_currency_decimal}"
  end

  def current_currency
    @current_currency ||=
      begin
        Currency.find_by_code(session[:current_currency]) || Currency.find_by_code('USD')
      end
  end

  def currency_selected_class(currency, current_currency)
    if currency.code == current_currency.code
      'currencies__item-link currencies__item-link--selected'
    else
      'currencies__item-link'
    end
  end
end
