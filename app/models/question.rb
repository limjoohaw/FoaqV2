class Question < ApplicationRecord
	has_one :answer
  belongs_to :user#, optional: true
end
