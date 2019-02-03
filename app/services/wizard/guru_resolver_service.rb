class Wizard::GuruResolverService
  def initialize(session)
    @session = session
  end

  def perform
    return saved_wizard if saved_wizard?
    new_wizard
  end

  private
    attr_reader :session

    def saved_wizard?
      wizard_session.present?
    end

    def saved_wizard
      Wizard::GuruService.new(wizard_session)
    end

    def new_wizard
      Wizard::GuruService.new.tap do |wizard|
        wizard_session = wizard.id
      end
    end

    def wizard_session
      session[:wizard_guru]
    end

    def wizard_session=(value)
      session[:wizard_guru] = value
    end
end
