class UsersController < ApplicationController
	
	# def show
	#   @user = current_user
	#   @user_questions = @user.questions
	#   @question = Question.new
	# end

	# def create
	#   @user = User.find(params[:id])

	#   @question = Question.new(question_params) 
	#   @question.receiver = @user.id #This does not work 
	#   if @question.save
	#       redirect_to root_path
	#   else
	#       render 'new'
	#   end
	#  end

	# private

	# def question_params
	#     params.require(:question).permit(:content, :user_id, :receiver)
	# end

end
