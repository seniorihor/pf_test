FactoryBot.define do
  factory :custom_field do
    # Required for STI
    initialize_with {
      klass = "CustomField::#{type.classify}".constantize
      klass.new(attributes)
    }

    sequence(:name) { |n| "field#{n}-#{SecureRandom.hex(4)}" }

    trait :text do
      type { 'text' }
    end

    trait :number do
      type { 'number' }
    end

    trait :select do
      type { 'select' }
    end

    trait :multiselect do
      type { 'multiselect' }
    end
  end
end
