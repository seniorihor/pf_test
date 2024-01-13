class CustomField::Multiselect < CustomField
  validates_with CustomField::MultiselectValidator

  class << self
    def sti_name
      'multiselect'
    end
  end
end
