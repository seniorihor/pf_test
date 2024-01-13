class CustomField < ApplicationRecord
  has_one :custom_field_value

  validates :name, presence: :true

  class << self
    def find_sti_class(name)
      case name
      when 'text'
        CustomField::Text
      when 'number'
        CustomField::Number
      when 'select'
        CustomField::Select
      when 'multiselect'
        CustomField::Multiselect
      else
        super
      end
    end
  end
end
