class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :application

  private
  	def application
  		if signed_in?
			  @notifications = current_user.notifications
			  @notifications_opened = @notifications.where.not('opened_at' => nil)
			  # @pending_answer = Answer.where(question_id: @question.id).count == 0
			  @notifications_unopened = current_user.notifications.unopened_only
			  @notifications_opened_time = Time.now
			end
		end

end
