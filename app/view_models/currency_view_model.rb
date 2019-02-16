class CurrencyViewModel < ApplicationViewModel
  def selected_class
    if model.code == options[:current_currency].code
      'currencies__item-link currencies__item-link--selected'
    else
      'currencies__item-link'
    end
  end
end
