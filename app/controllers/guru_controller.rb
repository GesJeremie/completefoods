class GuruController < BaseController
  before_action :ensure_allowed_step!, except: [:index]

  def index
    redirect_to action: wizard.current_step.name
  end

  def show
    # If finished display results of wizard
    # else redirect to root_path
  end

  def create


    wizard.current_step.tap do |step|
      step.answers = guru_params
      #step.completed = true
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

    def guru_params
      params.require(:answers).permit!
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
