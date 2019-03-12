module CurrencyHelper
  include ActionView::Helpers::NumberHelper

  def from_usd_to(currency, number)
    to_currency = number.to_money('USD').exchange_to(currency.code).to_f
    to_currency_decimal = sprintf('%.2f', to_currency)

    "#{currency.symbol}#{to_currency_decimal}"
  end
end
