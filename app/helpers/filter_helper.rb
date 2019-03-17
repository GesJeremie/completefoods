module FilterHelper
  def filter_checkbox_tag(attribute:, icon:, label:, value:)
    render 'products/filter_checkbox_tag',
      attribute: attribute,
      icon: icon,
      label: label,
      value: value
  end

  def filter_radio_button_tag(key:, value:, icon:, label:, checked:)
    render 'products/filter_radio_button_tag',
      key: key,
      value: value,
      icon: icon,
      label: label,
      checked: checked
  end
end
