class UsersController < ApplicationController

	def index
		@users = User.all
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		@user.update_attributes(allowed_params)
		@next = users_path
		@notice = "Update Successful"

		redirect_to @next, :notice => @notice
	end


	private

	def allowed_params
		params.require(:user).permit(:role, :nickname)
	end

end
