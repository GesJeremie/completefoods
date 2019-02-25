class Sort < ActiveHash::Base
  self.data = [
    { value: :price_highest_possible, label: 'Highest Possible', group: :price },
    { value: :price_lowest_possible, label: 'Lowest Possible', group: :price },
    { value: :carbs_highest, label: 'Highest', group: :carbs },
    { value: :carbs_lowest, label: 'Lowest', group: :carbs },
    { value: :carbs_ratio_highest, label: 'Highest', group: :carbs_ratio },
    { value: :carbs_ratio_lowest, label: 'Lowest', group: :carbs_ratio },
    { value: :protein_highest, label: 'Highest', group: :protein },
    { value: :protein_lowest, label: 'Lowest', group: :protein },
    { value: :protein_ratio_highest, label: 'Highest', group: :protein_ratio },
    { value: :protein_ratio_lowest, label: 'Lowest', group: :protein_ratio },
    { value: :fat_highest, label: 'Highest', group: :fat },
    { value: :fat_lowest, label: 'Lowest', group: :fat },
    { value: :fat_ratio_highest, label: 'Highest', group: :fat_ratio },
    { value: :fat_ratio_lowest, label: 'Lowest', group: :fat_ratio }
  ]

  def self.grouped
    self.all.group_by { |sort| sort[:group] }
  end

  def label_group
    "#{self.group.to_s.titleize} - #{label}"
  end
end
