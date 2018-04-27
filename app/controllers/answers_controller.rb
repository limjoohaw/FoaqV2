class AnswersController < ApplicationController

	# def index
	# 	@answers = Answer.all
	# end

	# def new
	# 	@answer = Answer.new
	# 	@answer = Question.answer.new(allowed_params)
	# 	@answer.question_id = params[:question_id]
	# end

	def create
		@answer = Answer.new
		@answer = current_user.answers.new(allowed_params)
		@question = Question.find(params[:question_id])
		@answer.question_id = params[:question_id]
		if @answer.save
			redirect_to question_path(@question)
    else
    	flash[:alert] = @answer.errors.full_messages.join(',')
    	render :new
    end
		# 	redirect_to answers_path
		# else
		# 	render :new
		# end
	end

	# def edit
	# 	@answer = Answer.find(params[:id])
	# end

	# def update
	# 	@answer = Answer.find(params[:id])
	# 	if @answer.update_attributes(allowed_params)
	# 		redirect_to answers_path
	# 	else
	# 		redender 'new'
	# 	end
	# end

	# def show
		# @answer = Answer.find(params[:question_id])
	# end


	def destroy
		@answer = Answer.find(params[:id])
		@answer.destroy
		redirect_to answers_path
	end


	private 

	def allowed_params
		params.require(:answer).permit(:response)
	end

end