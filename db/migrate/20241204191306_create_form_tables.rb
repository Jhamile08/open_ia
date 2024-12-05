class CreateFormTables < ActiveRecord::Migration[8.0]
  def change
    create_table :form_tables do |t|
      t.references :user, null: true, foreign_key: true
      t.string :name
      t.text :description
      t.boolean :processed_in_job

      t.timestamps
    end
  end
end
