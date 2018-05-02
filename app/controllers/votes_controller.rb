class VotesController < ApplicationController
  before_action :authenticate_user!
	# before_action :check_user

	def create
    @vote = Vote.new
    @vote.user_id = current_user.id
    @question = Question.find(params[:question_id])
    @vote.question_id = params[:question_id]
    @vote.save
   redirect_to question_path(@question)
  end


  private

  def allowed_params
    params.require(:vote)
	end
	
	def check_user
  	if
  		signed_in?
  	else
      @notice = "Please sign in before vote"
      redirect_to sign_in_path, :alert => @notice
    end
  end
  
end