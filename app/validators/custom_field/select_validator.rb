class CustomField::SelectValidator < ActiveModel::Validator
  def validate(record)
    if record.options.is_a?(Array)
      record.errors.add(:options, :is_empty) if record.options.empty?
    else
      record.errors.add(:options, :is_not_array)
    end
  end
end
