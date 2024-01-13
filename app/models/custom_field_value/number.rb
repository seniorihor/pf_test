class CustomFieldValue::Number < CustomFieldValue
  validates_with CustomFieldValue::NumberValidator

  class << self
    def sti_name
      'number'
    end
  end
end
