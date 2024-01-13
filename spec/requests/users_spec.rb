require 'rails_helper'
RSpec.describe "/users", type: :request do
  describe "PATCH /update" do
    describe "custom fields" do
      let(:user) { FactoryBot.create(:user) }
      let(:user_params) { {} }

      subject { patch user_url(user), params: { user: user_params } }

      context 'when field type is text' do
        let(:custom_field) { FactoryBot.create(:custom_field, :text) }
        let(:user_params) { { custom_field_values_attributes: [{ custom_field_id: custom_field.id, value: 'some text' }] } }

        it 'adds custom text field to user' do
          expect { subject }.to change{ user.reload.custom_field_values.count }.from(0).to(1)
          expect(user.custom_field_values.first.type).to eq('text')
        end
      end

      context 'when field type is number' do
        let(:custom_field) { FactoryBot.create(:custom_field, :number) }
        let(:user_params) { { custom_field_values_attributes: [{ custom_field_id: custom_field.id, value: 1 }] } }

        it 'adds custom number field to user' do
          expect { subject }.to change{ user.reload.custom_field_values.count }.from(0).to(1)
          expect(user.custom_field_values.first.type).to eq('number')
        end
      end

      context 'when field type is select' do
        let(:custom_field) { FactoryBot.create(:custom_field, :select, options: ['one', 'second', '3']) }
        let(:user_params) { { custom_field_values_attributes: [{ custom_field_id: custom_field.id, value: 'one' }] } }

        it 'adds custom select field to user' do
          expect { subject }.to change{ user.reload.custom_field_values.count }.from(0).to(1)
          expect(user.custom_field_values.first.type).to eq('select')
        end
      end

      context 'when field type is multiselect' do
        let(:custom_field) { FactoryBot.create(:custom_field, :multiselect, options: ['one', 'second', '3']) }
        let(:user_params) { { custom_field_values_attributes: [{ custom_field_id: custom_field.id, value: ['one', '3'] }] } }

        it 'adds custom multiselect field to user' do
          expect { subject }.to change{ user.reload.custom_field_values.count }.from(0).to(1)
          expect(user.custom_field_values.first.type).to eq('multiselect')
        end
      end

      context 'when batch of custom fields' do
        let(:custom_text_field) { FactoryBot.create(:custom_field, :text) }
        let(:custom_number_field) { FactoryBot.create(:custom_field, :number) }
        let(:custom_select_field) { FactoryBot.create(:custom_field, :select, options: ['one', 'second', '3']) }
        let(:custom_multiselect_field) { FactoryBot.create(:custom_field, :multiselect, options: ['one', 'second', '3']) }

        let(:user_params) do
          {
            custom_field_values_attributes: [
              { custom_field_id: custom_text_field.id, value: 'some text' },
              { custom_field_id: custom_number_field.id, value: 32 },
              { custom_field_id: custom_select_field.id, value: 'one' },
              { custom_field_id: custom_multiselect_field.id, value: ['one', '3'] }
            ]
          }
        end

        it 'adds all of the custom fields' do
          expect { subject }.to change{ user.reload.custom_field_values.count }.from(0).to(4)
          expect(user.custom_field_values.pluck(:type)).to eq(['text', 'number', 'select', 'multiselect'])
        end
      end
    end
  end
end
