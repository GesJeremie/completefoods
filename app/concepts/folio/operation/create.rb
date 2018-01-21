class Folio::Create < Trailblazer::Operation

  extend Contract::DSL

  step      Policy::Guard(:options?)
  step      :do_not_own_folio?
  step      Model(Folio, :new)
  success   :assign_folio_values
  step      Contract::Build(constant: Folio::Contract::Create)
  step      Contract::Validate()
  step      Contract::Persist()

  def options?(options, params:, **)
    options['current_user'].present? && options['current_user'].id.present?
  end

  def do_not_own_folio?(options, params:, **)
    options['current_user'].folio.nil?
  end

  def assign_folio_values(options, params:, **)
    options['model'].user_id = options['current_user'].id
    options['model'].currency_id = Currency.where(code: 'USD').first.id
  end

end
