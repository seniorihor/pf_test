class User < ApplicationRecord
  has_many :custom_field_values

  accepts_nested_attributes_for :custom_field_values, allow_destroy: true

  validates :username, presence: true
end
