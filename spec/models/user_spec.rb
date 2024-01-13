# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    describe 'custom fields' do
      let(:user) { FactoryBot.create(:user) }

      let(:type) { '' }
      let(:options) { nil }
      let(:custom_field) { FactoryBot.create(:custom_field, type, options: options) }

      subject { user.save }

      it { is_expected.to validate_presence_of(:value) }

      context 'when type is text' do
        let(:type) { 'text' }

        context 'when no text limit provided' do
          it 'is valid record' do
            user.custom_field_values.build(value: 'some text', custom_field:, type:)

            expect(subject).to be_truthy
          end

          it 'is not valid record' do
            user.custom_field_values.build(value: '', custom_field:, type:)

            expect(subject).to be_falsey
          end
        end

        context 'when text limit provided' do
          let(:options) { [5, 10] }

          it 'is valid record' do
            user.custom_field_values.build(value: 'some text', custom_field:, type:)

            expect(subject).to be_truthy
          end

          it 'is not valid record' do
            user.custom_field_values.build(value: 'some', custom_field:, type:)

            expect(subject).to be_falsey
          end
        end
      end

      context 'when type is number' do
        let(:type) { 'number' }

        context 'when text provided' do
          it 'is not valid record' do
            user.custom_field_values.build(value: '342', custom_field:, type:)

            expect(subject).to be_falsey
          end
        end

        context 'when no range provided' do
          it 'is valid record' do
            user.custom_field_values.build(value: 32, custom_field:, type:)

            expect(subject).to be_truthy
          end

          it 'is not valid record' do
            user.custom_field_values.build(value: nil, custom_field:, type:)

            expect(subject).to be_falsey
          end
        end

        context 'when range provided' do
          let(:options) { [5, 10] }

          it 'is valid record' do
            user.custom_field_values.build(value: 7, custom_field:, type:)

            expect(subject).to be_truthy
          end

          it 'is not valid record' do
            user.custom_field_values.build(value: 15, custom_field:, type:)

            expect(subject).to be_falsey
          end
        end
      end

      context 'when type is select' do
        let(:type) { 'select' }
        let(:options) { ['one', 'second', '3'] }

        context 'when value is not available' do
          it 'is not valid record' do
            user.custom_field_values.build(value: 'fourth', custom_field:, type:)

            expect(subject).to be_falsey
          end
        end

        context 'when value is available' do
          it 'is valid record' do
            user.custom_field_values.build(value: 'one', custom_field:, type:)

            expect(subject).to be_truthy
          end
        end
      end

      context 'when type is multiselect' do
        let(:type) { 'multiselect' }
        let(:options) { ['one', 'second', '3'] }

        context 'when value is not array' do
          it 'is not valid record' do
            user.custom_field_values.build(value: 'one', custom_field:, type:)

            expect(subject).to be_falsey
          end
        end

        context 'when value is empty array' do
          it 'is not valid record' do
            user.custom_field_values.build(value: [], custom_field:, type:)

            expect(subject).to be_falsey
          end
        end

        context 'when value is not available' do
          it 'is not valid record' do
            user.custom_field_values.build(value: ['one', 'fourth'], custom_field:, type:)

            expect(subject).to be_falsey
          end
        end

        context 'when value is available' do
          it 'is valid record' do
            user.custom_field_values.build(value: ['one'], custom_field:, type:)

            expect(subject).to be_truthy
          end
        end
      end
    end
  end
end
