class CustomFieldValue::SelectValidator < ActiveModel::Validator
  def validate(record)
    if record.custom_field.options.exclude?(record.value)
      record.errors.add(:value, :is_not_allowed)
    end
  end
end
