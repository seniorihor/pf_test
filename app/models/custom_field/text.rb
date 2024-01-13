class CustomField::Text < CustomField
  validates_with CustomField::TextValidator

  class << self
    def sti_name
      'text'
    end
  end
end
