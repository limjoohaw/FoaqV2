class AnswersController < ApplicationController

	def index
		@answers = Answer.all
	end

	def new
		@answer = Answer.new
	end

	def create
		@answer = Answer.new(allowed_params)
		if @answer.save
    else
    	flash[:alert] = @answer.errors.full_messages.join(',')
    	render :new
    end
		# 	redirect_to answers_path
		# else
		# 	render :new
		# end
	end

	def edit
		@answer = Answer.find(params[:id])
	end

	def update
		@answer = Answer.find(params[:id])
		if @answer.update_attributes(allowed_params)
			redirect_to answers_path
		else
			redender 'new'
		end
	end

	def show
		@answer = Answer.find(params[:id])
	end


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