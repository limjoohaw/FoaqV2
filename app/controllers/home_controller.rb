class HomeController < ApplicationController
	def index
		@questions = Question.all.order("created_at DESC")
		@answers = Answer.all.order("id DESC")
	end
end
