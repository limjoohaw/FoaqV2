class Question < ApplicationRecord
  belongs_to :user#, optional: true
	belongs_to :category
	has_one :answer
  has_one :answered_user, through: :answer, source: :user

  # attr_accessor :website
end
