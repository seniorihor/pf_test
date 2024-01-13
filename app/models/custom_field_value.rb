class CustomFieldValue < ApplicationRecord
  belongs_to :custom_field
  belongs_to :user

  after_initialize -> { self.type ||= custom_field.type }

  validates :value, presence: :true

  class << self
    def find_sti_class(name)
      case name
      when 'text'
        CustomFieldValue::Text
      when 'number'
        CustomFieldValue::Number
      when 'select'
        CustomFieldValue::Select
      when 'multiselect'
        CustomFieldValue::Multiselect
      else
        super
      end
    end
  end
end
