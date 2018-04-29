class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :application

  private
  	def application
  		if signed_in?
			  @notifications = current_user.notifications
			end
		end

end
