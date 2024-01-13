class CreateCustomFields < ActiveRecord::Migration[7.1]
  def change
    create_table :custom_fields do |t|
      t.string :type, null: false
      t.string :name, null: false
      t.jsonb :options
    end
  end
end
