require "link_thumbnailer"
class QuestionsController < ApplicationController
	
	before_action :authenticate_user!, except: [:index, :show, :searchresult]
	before_action :check_role, except: [:index, :show, :searchresult]

	def index
		@questions = Question.all.sort {|x,y| y.total_vote <=> x.total_vote}.first(5)
		@answers = Answer.all.order("id DESC")
		# @questions.each do |q|
		# 	q.website = LinkThumbnailer.generate(q.source_url) if q.source_url.present?
		# end
	end

	def new
    @question = Question.new
	end

	def create
    @question = current_user.questions.new(question_params)
    @question.linkthumbnailer = LinkThumbnailer.generate(@question.source_url) if @question.source_url.present?
    @notice = "Question create successful"
			if @question.save
	    	redirect_to question_path(@question)
	    	flash[:notice] = @notice
	    else
	    	flash[:alert] = @question.errors.full_messages.join(',')
	    	render :new
	    end
	end

	def show
		@question = Question.find(params[:id])
		if params[:opened_at]
			current_user.notifications.find(params[:noti_id]).update(opened_at: params[:opened_at])
		end
		@website = @question.linkthumbnailer
		if signed_in?
			@user_voted = Vote.where(user_id: current_user.id, question_id: @question.id).count != 0
		end
		@total_vote = Vote.where(question_id: @question.id).count
		# @website = LinkThumbnailer.generate(@question.source_url) if @question.source_url.present?
		@pending_answer = Answer.where(question_id: @question.id).count == 0
		@question_expired = @question.created_at + 5.minutes
		if signed_in?
			@selected_respondent = current_user.id == @question.respondent_id

		end
		@respondent_avatar = User.find(@question.respondent_id)
		@interragator_avatar = User.find(@question.user_id)
	end

	def searchresult
		# @questions = Question.user.where('nickname ilike ?', "%" + params[:searchkey] + "%")
		# @questions += Question.category.where('name ilike ?', "%" + params[:searchkey] + "%")
		# @questions.uniq!

		# SELECT * FROM questions WHERE country LIKE "%params[:searchkey]%" AND name LIKE "%params[:searchkey]%"
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