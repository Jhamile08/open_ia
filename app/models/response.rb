class Response < ApplicationRecord
  belongs_to :form_table

  # Validaciones
  validates :ai_response, presence: false, length: { maximum: 1000 }
  validates :status, presence: true
end
