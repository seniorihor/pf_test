class CustomFieldValue::TextValidator < ActiveModel::Validator
  def validate(record)
    if record.value.blank?
      record.errors.add(:value, :is_empty)
    elsif record.custom_field.options && Range.new(*record.custom_field.options).exclude?(record.value.length)
      record.errors.add(:value, :is_not_valid)
    end
  end
end
