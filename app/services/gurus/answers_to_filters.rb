class Gurus::AnswersToFilters
  attr_reader :answers
  attr_reader :filters

  def initialize(answers)
    @answers = answers
    @filters = {}
  end

  def perform
    add_filter(:gluten_free) if answer?(:gluten)
    add_filter(:lactose_free) if answer?(:lactose)

    add_filter(:vegan) if answer?(:vegan)
    add_filter(:vegetarian) if answer?(:vegetarian)

    add_filter(:canada) if answer_country?(:canada)
    add_filter(:united_states) if answer_country?(:united_states)
    add_filter(:europe) if answer_country?(:europe)
    add_filter(:rest_of_world) if answer_country?(:other)

    add_filter(:powder) if answer?(:powder)
    add_filter(:bottle) if answer?(:ready_to_drink)
    add_filter(:snack) if answer?(:snack)

    add_filter(:subscription_available) if answer_subscription?(:yes)

    if answer_subscription?(:yes_only_discount)
      add_filter(:subscription_available)
      add_filter(:discount_for_subscription)
    end

    filters
  end

  private

    def answer?(type)
      answers[type] == 'on'
    end

    def answer_country?(country)
      answers[:country] == country.to_s
    end

    def answer_subscription?(answer)
      answers[:subscription] == answer.to_s
    end

    def add_filter(name)
      @filters[name] = 'on'
    end
end
