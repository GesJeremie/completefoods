class Wizard < ApplicationRecord
  STEPS_ORDER = %w[allergen diet location type subscription sort narrow].freeze

  def step_completed?(step)
    steps_completed.include?(step)
  end

  def steps_completed
    STEPS_ORDER.slice(0, current_step_index)
  end

  def steps_remaining
    STEPS_ORDER - steps_completed
  end

  def steps_remaining_without_current_step
    steps_remaining - current_step
  end

  def previous_step
    steps_completed.last
  end

  def next_step
    steps_remaining_without_current_step.first
  end

  def started?
    current_step != STEPS_ORDER.first
  end

  def completed?
    current_step == 'completed'
  end

  private

    def current_step_index
      STEPS_ORDER.find_index(current_step)
    end
end
