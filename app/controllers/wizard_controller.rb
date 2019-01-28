class WizardController < BaseController
  before_action :set_current_wizard
  before_action :ensure_can_show_step!, except: [:index]
  before_action :set_current_step, except: [:index]

  def index
    redirect_to action: (current_wizard.current_step || Wizard::STEPS_ORDER.FIRST)
  end

  def allergen
  end

  def diet
  end

  def location
  end

  def type
  end

  def subscription
  end

  def sort
  end

  def narrow
  end

  def completed
  end

  private

    def set_current_wizard
      return if session[:current_wizard].present?

      session[:current_wizard] = Wizard.new.tap(&:save).id
    end

    def set_current_step
      current_wizard.current_step = action_name
      current_wizard.save
    end

    def current_wizard
      @current_wizard ||= Wizard.find_by_id(session[:current_wizard])
    end
end
