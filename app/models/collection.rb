class Collection < ActiveHash::Base
  self.data = [
    { group_id: 1, slug: 'cheapest' },
    { group_id: 1, slug: 'most-expensive'},

    { group_id: 2, slug: 'for-vegans' },
    { group_id: 2, slug: 'for-vegetarians' },

    { group_id: 3, slug: 'snacks'},
    { group_id: 3, slug: 'ready-to-drink' },
    { group_id: 3, slug: 'powders' },

    { group_id: 4, slug: 'for-athletes' },

    { group_id: 5, slug: 'gluten-free' },
    { group_id: 5, slug: 'lactose-free' },

    { group_id: 6, slug: 'made-in-canada' },
    { group_id: 6, slug: 'made-in-united-states' },
    { group_id: 6, slug: 'made-in-india' },
    { group_id: 6, slug: 'made-in-france' },
    { group_id: 6, slug: 'made-in-germany' },
    { group_id: 6, slug: 'made-in-netherlands' },
    { group_id: 6, slug: 'made-in-singapore' },
    { group_id: 6, slug: 'made-in-united-kingdom' },
    { group_id: 6, slug: 'made-in-czech-republic' },
    { group_id: 6, slug: 'made-in-italy' },
    { group_id: 6, slug: 'made-in-austria' },
    { group_id: 6, slug: 'made-in-finland' },
    { group_id: 6, slug: 'made-in-estonia' },
    { group_id: 6, slug: 'made-in-spain' },
    { group_id: 6, slug: 'made-in-sweden' },
    { group_id: 6, slug: 'made-in-india' }
  ]

  def name
    self.slug.titleize
  end

  def cover
    "#{self.slug.underscore}.jpg"
  end

  def group
    group = groups.find { |group| group[:id] == self.group_id }
    group[:slug]
  end

  private

    def groups
      [
        { id: 1, slug: 'price' },
        { id: 2, slug: 'diet' },
        { id: 3, slug: 'type' },
        { id: 4, slug: 'misc' },
        { id: 5, slug: 'allergen' },
        { id: 6, slug: 'country' }
      ]
    end

end
