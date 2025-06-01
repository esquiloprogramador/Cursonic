# app/controllers/api/v1/enrollments_controller.rb
class Api::V1::EnrollmentsController < ApplicationController

	def create
		enrollment = Enrollment.new(user: @current_user, course_id: params[:course_id])
		if enrollment.save
			render json: { message: 'Enrolled successfully' }, status: :created
		else
			render json: { errors: enrollment.errors.full_messages }, status: :unprocessable_entity
		end
	end

	def destroy
		enrollment = Enrollment.find_by(user: @current_user, course_id: params[:course_id])
		if enrollment&.destroy
			head :no_content
		else
			render json: { errors: ['Enrollment not found'] }, status: :not_found
		end
	end
end