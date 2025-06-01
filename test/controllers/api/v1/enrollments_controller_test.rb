require "test_helper"

class Api::V1::EnrollmentsControllerTest < ActionDispatch::IntegrationTest
	setup do
		@user = users(:one)
		@headers = auth_headers(@user)
		@course = Course.create!(title: "Curso", description: "Desc", slug: "curso")
		@enrollment = Enrollment.create!(user: @user, course: @course)
	end

	test "should create enrollment" do
		other_user = User.create!(email: "other@example.com", password: "password")
		other_course = Course.create!(title: "Outro Curso", description: "outro", slug: "outro")
		assert_difference("Enrollment.count") do
			post api_v1_course_enrollments_url(other_course),
			params: { user_id: other_user.id }.to_json,
			headers: @headers
		end
		assert_response :created
	end

	test "should not create enrollment without authentication" do
		post api_v1_course_enrollments_url(@course),
		params: { user_id: @user.id }.to_json
		assert_response :unauthorized
	end

	test "should delete enrollment" do
		assert_difference("Enrollment.count", -1) do
		delete api_v1_course_enrollments_url(@course),
			headers: @headers
		end
		assert_response :no_content
	end
end
