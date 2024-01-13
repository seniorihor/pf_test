class CustomFieldValue::Select < CustomFieldValue
  validates_with CustomFieldValue::SelectValidator

  class << self
    def sti_name
      'select'
    end
  end
end
