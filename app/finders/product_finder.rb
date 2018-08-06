class ProductFinder
  attr_reader :params

  def initialize(params = {})
    @params = params
  end

  def execute
    ProductFilterFinder.new(params).execute
  end

end
