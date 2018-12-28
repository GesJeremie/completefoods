module CurrencyHelper
  include ActionView::Helpers::NumberHelper

  def current_currency
    @current_currency ||=
      begin
        Currency.find_by_code(session[:current_currency]) || Currency.find_by_code('USD')
      end
  end

  def from_usd_to_current_currency(number)
    to_currency = number.to_money('USD').exchange_to(current_currency.code).to_f
    to_currency_decimal = sprintf('%.2f', to_currency)

    "#{current_currency.symbol}#{to_currency_decimal}"
  end

  def currency_selected_class(currency, current_currency)
    if currency.code == current_currency.code
      'currencies__item-link currencies__item-link--selected'
    else
      'currencies__item-link'
    end
  end
end
