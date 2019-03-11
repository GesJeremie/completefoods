module GuruHelper
  def guru_checkbox_tag(attribute:, icon:, label:, answer:)
    render 'gurus/checkbox_tag',
      attribute: attribute,
      icon: icon,
      label: label,
      answer: answer
  end

  def guru_radio_button_tag(key:, value:, icon:, label:, checked:)
    render 'gurus/radio_button_tag',
      key: key,
      value: value,
      icon: icon,
      label: label,
      checked: checked
  end
end
