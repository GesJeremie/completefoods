module ApplicationHelper
  include ActionView::Helpers::NumberHelper
  include ActionView::Helpers::AssetTagHelper

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
    Currency.find_by_code(session[:current_currency]) || Currency.find_by_code('USD')
  end

  def currency_selected_class(currency, current_currency)
    if currency.code == current_currency.code
      'currencies__item-link currencies__item-link--selected'
    else
      'currencies__item-link'
    end
  end

  def collection_made_in_description(products, country)
    description = []
    brands_count = products.group_by(&:brand_id).count


    if products.count > 1
        description << "There are over #{products.count} soylent alternatives"
    else
        description << 'There is currently only one soylent alternative'
    end

    description << "made in #{country.name}"

    if products.count > 2
      description << 'ranging from'
      description << "#{from_usd_to_current_currency(products.first.price.per_month_bulk_order_in_currency('USD'))}"
      description << 'to'
      description << "#{from_usd_to_current_currency(@products.last.price.per_month_bulk_order_in_currency('USD'))}"
      description << 'per month'
    end

    if brands_count > 2
       description << "and are produced by #{brands_count} brands"
    end

    description.join(' ') << '.'
  end
end
