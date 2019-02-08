class GuruStepViewModel < ApplicationViewModel
  def answer_for(key)
    current_step.answers[key.to_s] rescue nil
  end

  def checked_for?(key, value)
    value.to_s == answer_for(key)
  end

  def progress_current
    current_step_index + 1
  end

  def progress_total
    total_steps
  end

  def progress_height
    (progress_current * 100) / progress_total
  end

  def next_step
    model.step_after(current_step)
  end

  def previous_step
    model.step_before(current_step)
  end

  def previous_step_path
    return if previous_step.nil?

    "#{previous_step.name}_guru_path"
  end

  def previous_button?
    previous_step.present?
  end

  private

    def steps
      @steps ||= model.wizard_steps
    end

    def current_step
      @current_step ||= model.step(options[:current_step])
    end

    def current_step_index
      @current_step_index ||= steps.index(current_step)
    end

    def total_steps
      @total_steps ||= steps.count
    end
end
