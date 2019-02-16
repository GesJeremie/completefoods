class ApplicationViewModel
  include Rails.application.routes.url_helpers
  include ActionView::Helpers
  include ActionView::Context

  attr_reader :model, :options

  def self.wrap(input, options = {})
    if input.is_a?(Enumerable)
      input.map { |i| new(i, options) }
    else
      new(input, options)
    end
  end

  def initialize(model = nil, options = {})
    @model = model
    @options = if options.respond_to?(:to_unsafe_h)
                 options.to_unsafe_h.with_indifferent_access
               else
                 options.to_h.with_indifferent_access
               end
  end

  def method_missing(method, *args, &block)
    if model && model.respond_to?(method)
      # Define a method so the next call is faster
      self.class.send(:define_method, method) do |*args, &blok|
        model.send(method, *args, &blok)
      end

      send(method, *args, &block)
    else
      super
    end

  rescue NoMethodError => no_method_error
    super if no_method_error.name == method
    raise no_method_error
  end

  def respond_to?(*args)
    super || (model && model.respond_to?(*args))
  end
end
