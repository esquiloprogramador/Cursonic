# app/controllers/api/v1/materials_controller.rb
class Api::V1::MaterialsController < ApplicationController
	before_action :set_lesson

	def index
		materials = @lesson.materials
		render json: materials
	end

	def show
		material = @lesson.materials.find(params[:id])
		render json: material
	end

	def create
		material = @lesson.materials.new(material_params)
		if material.save
			render json: material, status: :created
		else
			render json: { errors: material.errors.full_messages }, status: :unprocessable_entity
		end
	end

	def update
		material = @lesson.materials.find(params[:id])
		if material.update(material_params)
			render json: material
		else
			render json: { errors: material.errors.full_messages }, status: :unprocessable_entity
		end
	end

	def destroy
		material = @lesson.materials.find(params[:id])
		material.destroy
		head :no_content
	end

	private

	def set_lesson
		@lesson = Lesson.find(params[:lesson_id])
	end

	def material_params
		params.require(:material).permit(:title, :file_url, :kind)
	end
end
