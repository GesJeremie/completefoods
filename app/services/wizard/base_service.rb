class Wizard::BaseService
  def initialize(wizard_id = nil, wizard_steps = [])
    @wizard_id = wizard_id
    @wizard_steps = wizard_steps
  end

  def id
    wizard.id
  end

  def steps
    wizard.wizard_steps.reorder('created_at ASC')
  end

  def step(name)
    steps.find_by_name(name)
  end

  def steps_completed
    steps.where(completed: true)
  end

  def steps_remaining
    steps.where(completed: false)
  end

  def steps_remaining_without_current
    steps_remaining - [current_step]
  end

  def current_step
    steps_remaining.first
  end

  def next_step
    steps_remaining.second
  end

  def previous_step
    steps_completed.last
  end

  def finished?
    steps_remaining.empty?
  end

  private
    attr_reader :wizard_id
    attr_reader :wizard_steps

    def wizard
      @wizard ||= fetch_wizard
    end

    def fetch_wizard
      return Wizard.find(wizard_id) if wizard_id.present?

      create_wizard
    end

    def create_wizard
      Wizard.new.tap do |wizard|
        wizard.wizard_steps = build_steps
        wizard.save
      end
    end

    def build_steps
      wizard_steps.map { |step| WizardStep.new(name: step) }
    end
end
