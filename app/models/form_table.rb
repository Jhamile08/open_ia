class FormTable < ApplicationRecord
  has_many :responses
  belongs_to :user, optional: true
end
