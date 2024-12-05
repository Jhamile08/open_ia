class CreateResponses < ActiveRecord::Migration[8.0]
  def change
    create_table :responses do |t|
      t.references :form_table, null: false, foreign_key: true
      t.text :ai_response
      t.string :status

      t.timestamps
    end
  end
end
