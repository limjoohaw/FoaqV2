class Question < ApplicationRecord
  belongs_to :user#, optional: true
	belongs_to :category
	has_one :answer
  has_one :answered_user, through: :answer, source: :user
  before_destroy :destroy_notification

  # attr_accessor :website
  def total_vote
  	Vote.where(question_id: self.id).count
  end

  def destroy_notification
  	self.user.notifications.destroy_all
  end

end
