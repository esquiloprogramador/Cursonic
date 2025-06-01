# app/controllers/api/v1/comments_controller.rb
class Api::V1::CommentsController < ApplicationController
	before_action :set_lesson

	def index
		comments = @lesson.comments.includes(:user).order(created_at: :desc)
		render json: comments.as_json(include: { user: { only: [:id, :name, :email] } })
	end

	def create
		comment = @lesson.comments.new(comment_params.merge(user: @current_user))
		if comment.save
			render json: comment, status: :created
		else
			render json: { errors: comment.errors.full_messages }, status: :unprocessable_entity
		end
	end

	def destroy
		comment = @lesson.comments.find(params[:id])
		if comment.user == @current_user
			comment.destroy
			head :no_content
		else
			render json: { error: "Not authorized" }, status: :forbidden
		end
	end

	private

	def set_lesson
		@lesson = Lesson.find(params[:lesson_id])
	end

	def comment_params
		params.require(:comment).permit(:body)
	end
end
