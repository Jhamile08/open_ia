class FormTable < ApplicationRecord
  has_many :responses, dependent: :destroy
  belongs_to :user, optional: true

  # Validaciones
  validates :name, presence: true, length: { maximum: 100 }
  validates :description, length: { maximum: 500 }, allow_blank: true
  validates :processed_in_job, inclusion: { in: [ true, false ] }
  def latest_response
    responses.last
  end
end
