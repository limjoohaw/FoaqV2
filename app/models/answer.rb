class Answer < ApplicationRecord
	belongs_to :question
	belongs_to :user
  before_destroy :destroy_notification
	# acts_as_notifiable configures your model as ActivityNotification::Notifiable
  # with parameters as value or custom methods defined in your model as lambda or symbol.
  # The first argument is the plural symbol name of your target model.
  acts_as_notifiable :users,
    # Notification targets as :targets is a necessary option
    # Set to notify to author and users commented to the article, except comment owner self
    targets: ->(answer, key) {
      # ([answer.question.user] + answer.question.answered_users.to_a - [answer.user]).uniq
      [answer.question.user]
    },
    # Set { only: [:create] } to :tracked option to generate tracked notifications for creation only.
    # It adds required callbacks to generate notifications for creation of the notifiable model.
    tracked: { only: [:create], key: "Your question have been answered!" }
    # Path to move when the notification is opened by the target user
    # This is an optional configuration since activity_notification uses polymorphic_path as default
  #   notifiable_path: :question_notifiable_path

  # def question_notifiable_path
  #   question_path(question)
  # end

  def question_notifiable_path
    question_path(question)
  end

  def destroy_notification
    self.user.notifications.destroy_all
  end
  
end