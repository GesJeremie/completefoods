class FolioCryptoCurrency::Update < Trailblazer::Operation

  extend Contract::DSL

  contract 'params', (Dry::Validation.Schema do
    required(:id).filled
    required(:holding).filled
  end)

  step      Contract::Validate(name: 'params'), before: 'operation.new'
  step      Policy::Guard(:current_user?)
  step      Policy::Guard(:own_folio?)
  step      Model(FolioCryptoCurrency, :find_by)
  step      Contract::Build(constant: FolioCryptoCurrency::Contract::Update)
  step      Contract::Validate()
  step      Contract::Persist()


  def current_user?(options, params:, **)
    options['current_user'].present? && options['current_user'].id.present?
  end

  def own_folio?(options, params:, **)
    options['current_user'].folio.id == FolioCryptoCurrency.find(params[:id]).folio_id
  end


end
