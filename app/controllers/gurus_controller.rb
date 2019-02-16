class GurusController < BaseController
  before_action :set_view_model,
    only: %i[allergen diet country type subscription email]

  before_action :save_answers,
    only: %i[allergen_create diet_create country_create type_create subscription_create email_create]

  def index
    if wizard.finished?
      token = wizard.token
      session[:guru_wizard] = nil
      redirect_to(action: :show, id: token) and return
    else
      redirect_to(action: wizard.current_step.name) and return
    end
  end

  def show
    model = Wizard.find_by!(token: params[:id])
    redirect_to(action: :index) unless model.finished?

    params[:sort] = params[:sort] || 'price_lowest_possible'
    products = GuruProductsFinder.new(model.answers).perform
    products = Refinements::Sort.new(products, params[:sort]).perform

    @products = []

    @guru = model
    #@products = ProductViewModel.wrap(
    #  products,
    #  view_model_options
    #)
  end

  def allergen; end
  def allergen_create
    redirect_to_next_step
  end

  def diet; end
  def diet_create
    redirect_to_next_step
  end

  def country; end
  def country_create
    redirect_to_next_step
  end

  def type; end
  def type_create
    redirect_to_next_step
  end

  def subscription; end
  def subscription_create
    redirect_to_next_step
  end

  def narrow; end
  def narrow_create
    redirect_to_next_step
  end

  def email; end
  def email_create
    redirect_to_next_step
  end

  def no_results; end

  private

    #
    # Before Actions
    #
    def set_view_model
      @guru_step = GuruStepViewModel.wrap(
        wizard,
        view_model_options.merge(current_step: current_step)
      )
    end

    def save_answers
      wizard.step(current_step).tap do |step|
        step.completed = true
        step.answers = send("#{current_step}_params")
        step.save
      end
    end

    #
    # Methods
    #
    def redirect_to_next_step
      next_step = wizard.step_after(
        wizard.step(current_step)
      )

      if next_step.present?
        redirect_to action: next_step.name and return
      else
        redirect_to action: :index and return
      end
    end

    def current_step
      action_name
      .remove('_create')
      .to_sym
    end

    #
    # Wizards
    #
    def wizard
      @wizard ||= (saved_wizard || new_wizard)
    end

    def saved_wizard
      Wizard.find_by_id(session[:guru_wizard])
    end

    def new_wizard
      Wizards::BuilderGuru.new.create.tap do |wizard|
        session[:guru_wizard] = wizard.id
      end
    end

    #
    # Params
    #
    def answers_params(*allowed_answers)
      params.permit(answers: allowed_answers)[:answers]
    end

    def allergen_params
      answers_params(:gluten, :lactose)
    end

    def diet_params
      answers_params(:vegan, :vegetarian)
    end

    def country_params
      answers_params(:country)
    end

    def type_params
      answers_params(:powder, :ready_to_drink, :snack)
    end

    def subscription_params
      answers_params(:yes, :yes_only_discount)
    end

    def email_params
      answers_params(:email)
    end
end
