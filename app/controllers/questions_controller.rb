require "link_thumbnailer"
class QuestionsController < ApplicationController
	
	before_action :authenticate_user!, except: [:index, :show]
	before_action :check_role, except: [:index, :show]

	def index
		@questions = Question.all
		# @questions.each do |q|
		# 	q.website = LinkThumbnailer.generate(q.source_url) if q.source_url.present?
		# end
	end

	def new
    @question = Question.new
		@categories = Category.all
	end

	def create
    @question = current_user.questions.new(question_params)
    @question.linkthumbnailer = LinkThumbnailer.generate(@question.source_url) if @question.source_url.present?
			if @question.save
      	redirect_to question_path(@question)
      else
      	flash[:alert] = @question.errors.full_messages.join(',')
      	render :new
      end
    # @question.user_id = current_user.id
	end

	def show
		@question = Question.find(params[:id])
		@website = @question.linkthumbnailer

		# @website = LinkThumbnailer.generate(@question.source_url) if @question.source_url.present?
	end


	private

	def question_params
	    params.require(:question).permit(:title, :description, :source_url, :linkthumbnailer, :category_id, :respondent_id)
	end

	def check_role
		if current_user.respondent?
			redirect_to root_path
		end
	end

end