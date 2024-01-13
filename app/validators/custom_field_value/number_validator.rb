class CustomFieldValue::NumberValidator < ActiveModel::Validator
  def validate(record)
    if record.value.blank?
      record.errors.add(:value, :is_empty)
    elsif !record.value.is_a?(Numeric)
      record.errors.add(:value, :is_not_a_number)
    elsif record.custom_field.options && Range.new(*record.custom_field.options).exclude?(record.value)
      record.errors.add(:value, :is_not_valid)
    end
  end
end
