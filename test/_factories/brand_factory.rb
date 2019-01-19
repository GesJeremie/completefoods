class BrandFactory

  def initialize(overrides = {})
    @overrides = overrides
  end

  def build
    Brand.new(attributes)
  end

  def create
    brand = build

    brand.save
    brand
  end

  private

    def attributes
      {
        country: Country.all.sample,
        name: Faker::FunnyName.name,
        website: Faker::Internet.url,
        facebook: 'https://facebook.com/'
      }.merge(@overrides)
    end
end
