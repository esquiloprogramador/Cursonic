require "test_helper"

class Api::V1::CoursesControllerTest < ActionDispatch::IntegrationTest
	setup do
		@user = users(:one) # você pode usar fixtures ou criar manual
		@headers = auth_headers(@user)
		@course = Course.create!(title: "Curso Teste", description: "Descrição", slug: "curso-teste")
	end

	test "should get index" do
		get api_v1_courses_url, headers: @headers
		assert_response :success
		assert_includes @response.body, @course.title
	end

	test "should show course" do
		get api_v1_course_url(@course), headers: @headers
		assert_response :success
		assert_includes @response.body, @course.title
	end

	test "should return 404 for missing course" do
		get api_v1_course_url(id: 9999), headers: @headers
		assert_response :not_found
	end

	test "should create course" do
		assert_difference("Course.count") do
			post api_v1_courses_url,
				params: { title: "Novo Curso", description: "Top", slug: "novo-curso" }.to_json,
				headers: @headers
		end
		assert_response :created
	end

	test "should not create invalid course" do
		post api_v1_courses_url,
			params: { title: "" }.to_json,
			headers: @headers
		assert_response :unprocessable_entity
	end

	test "should update course" do
		put api_v1_course_url(@course),
			params: { title: "Atualizado" }.to_json,
			headers: @headers
		assert_response :success
		assert_match "Atualizado", @response.body
	end

	test "should delete course" do
		assert_difference("Course.count", -1) do
			delete api_v1_course_url(@course), headers: @headers
		end
		assert_response :no_content
	end
end
