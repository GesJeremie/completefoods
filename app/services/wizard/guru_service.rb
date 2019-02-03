class Wizard::GuruService < Wizard::BaseService
  def initialize(wizard_id = nil)
    super(wizard_id, wizard_steps)
  end

  private
    def wizard_steps
      %w[allergen diet location type subscription sort narrow]
    end
end
