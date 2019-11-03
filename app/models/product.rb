class Product < ApplicationRecord
  STATES = %w[powder bottle snack].freeze
  FLAVORS = %w[sweet savoury neutral].freeze

  belongs_to :brand, touch: true

  enum state: STATES.map(&:to_sym)
  enum flavor: FLAVORS.map(&:to_sym)

  has_one :allergen, class_name: 'ProductAllergen', dependent: :destroy
  has_one :diet, class_name: 'ProductDiet', dependent: :destroy
  has_one :price, class_name: 'ProductPrice', dependent: :destroy
  has_one :shipment, class_name: 'ProductShipment', dependent: :destroy
  has_many :votes, class_name: 'ProductVote', dependent: :destroy

  has_one_attached :image

  accepts_nested_attributes_for :allergen
  accepts_nested_attributes_for :diet
  accepts_nested_attributes_for :price
  accepts_nested_attributes_for :shipment

  validates :brand_id, presence: true
  validates :slug, presence: true, uniqueness: true
  validates :name, presence: true
  validates :kcal_per_serving, presence: true, numericality: true
  validates :protein_per_serving, presence: true, numericality: true
  validates :carbs_per_serving, presence: true, numericality: true
  validates :fat_per_serving, presence: true, numericality: true
  validates :subscription_available, inclusion: BOOLEANS
  validates :discount_for_subscription, inclusion: BOOLEANS
  validates :state, inclusion: STATES
  validates :flavor, inclusion: FLAVORS
  validates :active, inclusion: BOOLEANS

  validates_with ImageUploadValidator, attributes: [:image]

  def self.preload_defaults
    includes(
      :allergen,
      :diet,
      :shipment,
      { price: [:currency] },
      { image_attachment: [:blob] },
      { brand: [:country] }
    )
  end

  def self.active
    where(active: true)
  end

  def self.search(query)
    joins(brand: :country).where('
      products.name ILIKE ANY (ARRAY[:terms]) OR
      countries.name ILIKE ANY (ARRAY[:terms]) OR
      brands.name ILIKE ANY (ARRAY[:terms])',
      terms: query.split.map { |term| '%' + term + '%' }
    )
  end

  def to_param
    slug
  end

  def protein_per_kcal(kcal)
    (protein_per_serving / kcal_per_serving) * kcal
  end

  def carbs_per_kcal(kcal)
    (carbs_per_serving / kcal_per_serving) * kcal
  end

  def fat_per_kcal(kcal)
    (fat_per_serving / kcal_per_serving) * kcal
  end

  def protein_ratio
    ratios.protein_ratio
  end

  def carbs_ratio
    ratios.carbs_ratio
  end

  def fat_ratio
    ratios.fat_ratio
  end

  private

    def ratios
      @ratios ||= ProductRatio.new(self)
    end
end
