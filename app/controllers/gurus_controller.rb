class GurusController < BaseController
  #before_action :ensure_allowed_step!, except: [:index]

  def index
    redirect_to action: wizard.current_step.name
  end

  def show
    # If finished display results of wizard
    # else redirect to root_path
  end

  # def create
  #   wizard.current_step.tap do |step|
  #     step.answers = guru_params
  #     #step.completed = true
  #     step.save
  #   end

  #   redirect_to action: wizard.next_step.name
  # end

  def allergen
    @guru_step = step_view_model(:allergen)
  end

  def allergen_create
    wizard.step(:allergen).tap do |step|
      step.completed = true
      step.answers = allergen_params
      step.save
    end

    redirect_to action: :index
  end

  def diet
    #@guru = Gurus::DietViewModel.wrap(wizard, view_model_options)
  end

  def diet_create
  end

  def location
  end

  def location_create
  end

  def type
  end

  def type_create
  end

  def subscription
  end

  def subscription_create
  end

  def sort
  end

  def sort_create
  end

  def narrow
  end

  def narrow_create
  end

  private

    def wizard
      @wizard ||= Wizard::GuruResolverService.new(session).perform
    end

    def step_view_model(current_step)
      GuruStepViewModel.wrap(
        wizard,
        view_model_options.merge(current_step: :allergen)
      )
    end

    def answers_params
      params.require(:answers)
    end

    def allergen_params
      answers_params.permit(:gluten, :lactose)
    end

    def diet_params
      answers_params.permit(:vegan, :vegetarian)
    end

    #def ensure_allowed_step!
    #  unless wizard.step_allowed?(action_name)
    #    redirect_to action: :index
    #  end
    #end
end
