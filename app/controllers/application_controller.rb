# app/controllers/application_controller.rb
class ApplicationController < ActionController::API
	before_action :authenticate_request

	private

	def authenticate_request
		header = request.headers['Authorization']
		header = header.split.last if header
		Rails.logger.debug header
		decoded = jwt_decode(header)
		Rails.logger.debug decoded
		@current_user = User.find(decoded[:user_id])
	rescue
		render json: { error: 'Não autorizado' }, status: :unauthorized
	end

	def jwt_decode(token)
		decoded = JWT.decode(token, Rails.application.secret_key_base)[0]
		ActiveSupport::HashWithIndifferentAccess.new decoded
	end

	def current_user
		@current_user
	end
end
