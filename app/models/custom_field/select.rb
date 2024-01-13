class CustomField::Select < CustomField
  validates_with CustomField::SelectValidator

  class << self
    def sti_name
      'select'
    end
  end
end
