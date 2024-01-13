class CreateCustomFieldValues < ActiveRecord::Migration[7.1]
  def change
    create_table :custom_field_values do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :custom_field, index: true, foreign_key: true

      t.string :type, null: false
      t.json :value
    end
  end
end
