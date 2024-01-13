class CustomFieldValue::Text < CustomFieldValue
  validates_with CustomFieldValue::TextValidator

  class << self
    def sti_name
      'text'
    end
  end
end
