class HomeController < ApplicationController
	def index
		@questions = Question.all.sort {|x,y| y.total_vote <=> x.total_vote}.first(5)
		@answers = Answer.all.order("id DESC")
	end
end
