class Api::V1::AuthController < ApplicationController
	skip_before_action :authenticate_request
	def login
		user = User.find_by(email: params[:email])
		if user&.authenticate(params[:password])
			token = jwt_encode(user_id: user.id)
			render json: { token: token }, status: :ok
		else
			render json: { error: 'Email ou senha inválidos' }, status: :unauthorized
		end
	end

	private

	def jwt_encode(payload, exp = 24.hours.from_now)
		payload[:exp] = exp.to_i
		JWT.encode(payload, Rails.application.secret_key_base)
	end
end
