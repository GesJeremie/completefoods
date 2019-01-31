class WizardGuruService
  STEPS = %w[allergen diet location type subscription sort narrow].freeze

  def initialize(session_id = nil)
    @session_id = session_id
  end

  def id
    wizard.id
  end

  def steps
    wizard.wizard_steps
  end

  def current_step
    steps_remaining.first
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

  def step_allowed?(step_name)
    !steps_remaining_without_current.map(&:name).include?(step_name)
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
    attr_reader :session_id

    def wizard
      @wizard ||= fetch_wizard
    end

    def fetch_wizard
      return Wizard.find(session_id) if session_id.present?

      create_wizard
    end

    def create_wizard
      Wizard.new.tap do |wizard|
        wizard.wizard_steps = build_steps
        wizard.save
      end
    end

    def build_steps
      STEPS.map { |step| build_step(step) }
    end

    def build_step(name)
      WizardStep.new.tap do |step|
        step.name = name
      end
    end
end
