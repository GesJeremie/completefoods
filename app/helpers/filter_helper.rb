module FilterHelper
  def filter_checkbox_tag(attribute:, icon:, label:, value:, data: nil)
    render 'products/filter_checkbox_tag',
      attribute: attribute,
      icon: icon,
      label: label,
      value: value,
      data: data
  end
end
