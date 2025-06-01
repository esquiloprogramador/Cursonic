# app/controllers/api/v1/lessons_controller.rb
class Api::V1::LessonsController < ApplicationController
	before_action :set_course

	def index
		lessons = @course.lessons.order(:position)
		render json: lessons
	end

	def show
		lesson = @course.lessons.find(params[:id])
		render json: lesson
	end

	def create
		lesson = @course.lessons.new(lesson_params)
		if lesson.save
			render json: lesson, status: :created
		else
			render json: { errors: lesson.errors.full_messages }, status: :unprocessable_entity
		end
	end

	def update
		lesson = @course.lessons.find(params[:id])
		if lesson.update(lesson_params)
			render json: lesson
		else
			render json: { errors: lesson.errors.full_messages }, status: :unprocessable_entity
		end
	end

	def destroy
		lesson = @course.lessons.find(params[:id])
		lesson.destroy
		head :no_content
	end

	private

	def set_course
		@course = Course.find(params[:course_id])
	end

	def lesson_params
		params.require(:lesson).permit(:title, :position)
	end
end
