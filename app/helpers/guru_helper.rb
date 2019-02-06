module GuruHelper
  def guru_checkbox_tag(attribute:, icon:, label:, answer:)
    render partial: 'gurus/checkbox_tag', locals: {
      attribute: attribute,
      icon: icon,
      label: label,
      answer: answer
    }
  end

  def guru_radio_button_tag(key:, value:, icon:, label:, checked:)
    render partial: 'gurus/radio_button_tag', locals: {
      key: key,
      value: value,
      icon: icon,
      label: label,
      checked: checked
    }
  end
end
