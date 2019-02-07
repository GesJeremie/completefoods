class Wizard < ApplicationRecord
  has_secure_token
  has_many :wizard_steps

  def step(name)
    wizard_steps.find_by_name(name)
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

  def step_after(step)
    wizard_steps.reorder('')
  end

  def step_before(step)
  end

  def finished?
    steps_remaining.empty?
  end

  private

    def steps
      wizard_steps.reorder('created_at ASC')
    end
end
