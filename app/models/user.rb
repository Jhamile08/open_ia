class User < ApplicationRecord
  has_many :form_tables

  # validaciones
  validates :name, presence: true
  validates :email, presence: true
end
