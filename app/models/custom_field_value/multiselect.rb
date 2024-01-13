class CustomFieldValue::Multiselect < CustomFieldValue
  validates_with CustomFieldValue::MultiselectValidator

  class << self
    def sti_name
      'multiselect'
    end
  end
end
