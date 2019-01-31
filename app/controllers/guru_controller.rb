class GuruController < BaseController
  before_action :ensure_allowed_step!, except: [:index]

  def index
    redirect_to action: wizard.current_step.name
  end

  def create
    wizard.current_step.tap do |step|
      step.answers = wizard_params
      step.completed = true
      step.save
    end

    redirect_to action: wizard.next_step.name
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

  private

    def wizard_params
      params.permit(:answers)
    end

    def wizard
      @wizard ||= fetch_wizard
    end

    def fetch_wizard
      if session[:wizard].present?
        WizardGuruService.new(session[:wizard])
      else
        WizardGuruService.new.tap do |wizard|
          session[:wizard] = wizard.id
        end
      end
    end

    def ensure_allowed_step!
      unless wizard.step_allowed?(action_name)
        redirect_to action: :index
      end
    end
end
