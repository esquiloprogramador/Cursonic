# app/controllers/api/v1/courses_controller.rb
class Api::V1::CoursesController < ApplicationController
				before_action :set_course, only: [:show, :update, :destroy]

				def index
								render json: Course.all
				end

				def show
								render json: @course
				end

				def create
								course = Course.new(course_params)
								if course.save
												render json: course, status: :created
								else
												render json: { errors: course.errors.full_messages }, status: :unprocessable_entity
								end
				end

				def update
								if @course.update(course_params)
												render json: @course
								else
												render json: { errors: @course.errors.full_messages }, status: :unprocessable_entity
								end
				end

				def destroy
								@course.destroy
								head :no_content
				end

				private

				def set_course
								@course = Course.find(params[:id])
				end

				def course_params
								params.expect(course: [:title, :description, :slug, :published])
				end
end
