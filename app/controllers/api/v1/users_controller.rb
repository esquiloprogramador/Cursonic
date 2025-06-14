# app/controllers/api/v1/users_controller.rb
class Api::V1::UsersController < ApplicationController
	skip_before_action :authenticate_request, only: [:create]
	before_action :set_user, only: [:show, :update, :destroy]

	def index
		render json: User.all
	end

	def show
		render json: @user
	end

	def create
		user = User.new(user_params)
		if user.save
			render json: user, status: :created
		else
			render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
		end
	end

	def update
		if @user.update(user_params)
			render json: @user
		else
			render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
		end
	end

	def destroy
		@user.destroy
		head :no_content
	end

	private

	def set_user
		@user = User.find(params[:id])
	end

	def user_params
		params.expect(user: [:name, :email, :password, :password_confirmation, :admin])
	end
end
