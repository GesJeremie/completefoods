class FolioCryptoCurrency::Destroy < Trailblazer::Operation

  extend Contract::DSL

  contract 'params', (Dry::Validation.Schema do
    required(:id).filled
  end)

  step      Contract::Validate(name: 'params'), before: 'operation.new'
  step      Policy::Guard(:options?)
  step      Policy::Guard(:own_folio?)
  success   :delete


  def options?(options, params:, **)
    options['current_user'].present? && options['current_user'].id.present?
  end

  def own_folio?(options, params:, **)
    options['current_user'].folio.id == FolioCryptoCurrency.find(params[:id]).folio_id
  end

  def delete(options, params:, **)
    FolioCryptoCurrency.find(params[:id]).destroy
  end

end
