class CustomField::Number < CustomField
  validates_with CustomField::NumberValidator

  class << self
    def sti_name
      'number'
    end
  end
end
