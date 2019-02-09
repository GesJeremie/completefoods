class Wizard < ApplicationRecord
  has_secure_token
  has_many :wizard_steps

  def answers
    wizard_steps.pluck(:answers).compact.reduce({}, :merge)
  end

  def step(name)
    wizard_steps.find_by_name(name)
  end

  def step_index(step)
    wizard_steps.find_index(step)
  end

  def steps_completed
    wizard_steps.where(completed: true)
  end

  def steps_remaining
    wizard_steps.where(completed: false)
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

  def step_after(step)
    return if step_index(step) == wizard_steps.size
    wizard_steps[ step_index(step) + 1 ]
  end

  def step_before(step)
    return if step_index(step) == 0
    wizard_steps[ step_index(step) - 1 ]
  end

  def finished?
    steps_remaining.empty?
  end
end
