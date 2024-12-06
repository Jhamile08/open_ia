class User < ApplicationRecord
  has_many :form_tables
    validates :name, presence: true
  validates :email, presence: true
end
