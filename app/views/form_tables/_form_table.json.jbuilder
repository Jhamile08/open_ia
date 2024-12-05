json.extract! form_table, :id, :user_id, :name, :description, :processed_in_job, :created_at, :updated_at
json.url form_table_url(form_table, format: :json)
