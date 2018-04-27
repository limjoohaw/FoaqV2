require "link_thumbnailer"
class QuestionsController < ApplicationController
	
	before_action :authenticate_user!, except: [:index, :show]

	def index
		@questions = Question.all

		@questions.each do |q|
			q.website = LinkThumbnailer.generate(q.source_url) if q.source_url.present?
		end
	end

	def new
    @question = Question.new
	end

	def create
    @question = current_user.questions.new(question_params)
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
		@website = LinkThumbnailer.generate(@question.source_url) if @question.source_url.present?
	end	


	private

	def question_params
	    params.require(:question).permit(:title, :description, :source_url, :linkthumbnailer)
	end

end



# class QuestionsController < ApplicationController
	# def index
	# 	@questions = Question.all
	# 	@websites = @questions.map { |q| LinkThumbnailer.generate(q.my_link)}
	# end

	# def new
	# 	@question = Question.new
	# end

	# def create
	# 	@question = Question.new(allowed_params)
	# 	@question.save
	# 	redirect_to question_path(@question)
	# end
	
	# def show
	# 	@question = Question.find(params[:id])
	# 	@preview = LinkThumbnailer.generate(@question.my_link)
	# end	
