class CustomFieldValue::MultiselectValidator < ActiveModel::Validator
  def validate(record)
    if !record.value.is_a?(Array)
      record.errors.add(:value, :is_not_array)
    elsif record.value.empty?
      record.errors.add(:value, :is_empty)
    elsif (record.value - record.custom_field.options).any?
      record.errors.add(:value, :is_not_allowed)
    end
  end
end
