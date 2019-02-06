class Wizards::Builder
  def steps
    []
  end

  def create
    Wizard.new.tap do |wizard|
      wizard.wizard_steps = build_steps
      wizard.save
    end
  end

  private

    def build_steps
      steps.map { |step| WizardStep.new(name: step) }
    end
end
