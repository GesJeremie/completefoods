class GurusController < BaseController
  before_action :set_view_models,
    only: %i[allergen diet location type subscription sort narrow]

  before_action :save_answers,
    only: %i[allergen_create diet_create location_create type_create subscription_create sort_create narrow_create]

  def index
    redirect_to action: wizard.current_step.name
  end

  def show
    # If finished display results of wizard
    # else redirect to root_path
  end

  def allergen; end
  def allergen_create
    redirect_to action: :index
  end

  def diet; end
  def diet_create
    redirect_to action: :index
  end

  def location; end
  def location_create
    redirect_to action: :index
  end

  def type; end
  def type_create
    redirect_to action: :index
  end

  def subscription; end
  def subscription_create
    redirect_to action: :index
  end

  def sort; end
  def sort_create
  end

  def narrow; end
  def narrow_create
    redirect_to action: :index
  end

  private

    def set_view_models
      step = action_name.to_sym
      @guru_step = step_view_model(step)
    end

    def save_answers
      step = action_name.remove('_create').to_sym
      save_answers_for_step(step)
    end

    def wizard
      @wizard ||= (saved_wizard || new_wizard)
    end

    def saved_wizard
      @saved_wizard ||= Wizard.find_by_id(session[:guru_wizard])
    end

    def new_wizard
      Wizards::BuilderGuru.new.create.tap do |wizard|
        session[:guru_wizard] = wizard.id
      end
    end

    def step_view_model(current_step)
      GuruStepViewModel.wrap(
        wizard,
        view_model_options.merge(current_step: current_step)
      )
    end

    def save_answers_for_step(name)
      wizard.step(name).tap do |step|
        step.completed = true
        step.answers = send("#{name}_params")
        step.save
      end
    end

    def answers_params(*allowed_answers)
      params.permit(answers: allowed_answers)[:answers]
    end

    def allergen_params
      answers_params(:gluten, :lactose)
    end

    def diet_params
      answers_params(:vegan, :vegetarian)
    end

    def location_params
      answers_params(:country)
    end

    def type_params
      answers_params(:powder, :ready_to_drink, :snack)
    end
end
