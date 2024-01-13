class CustomField::TextValidator < ActiveModel::Validator
  def validate(record)
    options = record.options

    return if options.nil? || (options.is_a?(Array) && options.count == 2 && options.first <= options.last)

    record.errors.add(:options, :is_not_valid)
  end
end
