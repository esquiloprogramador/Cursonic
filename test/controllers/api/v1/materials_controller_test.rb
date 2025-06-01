require "test_helper"

class Api::V1::MaterialsControllerTest < ActionDispatch::IntegrationTest
	setup do
		@user = users(:one)
		@headers = auth_headers(@user)
		@course = Course.create!(title: "Curso", description: "Desc", slug: "curso")
		@lesson = Lesson.create!(title: "Aula", course: @course)
		@material = Material.create!(lesson: @lesson, title: "PDF", kind: "pdf", file_url: "http://ex.com/file.pdf")
	end

	test "should get index" do
		get api_v1_course_lesson_materials_url(@course, @lesson), headers: @headers
		assert_response :success
		assert_includes @response.body, @material.title
	end

	test "should show material" do
		get api_v1_course_lesson_material_url(@course, @lesson, @material), headers: @headers
		assert_response :success
	end

	test "should create material" do
		assert_difference("Material.count") do
		post api_v1_course_lesson_materials_url(@course, @lesson),
			params: { title: "Novo material", kind: "pdf", file_url: "http://ex.com/new.pdf" }.to_json,
			headers: @headers
		end
		assert_response :created
	end

	test "should not create material without authentication" do
		post api_v1_course_lesson_materials_url(@course, @lesson),
		params: { title: "Material sem login" }.to_json
		assert_response :unauthorized
	end

	test "should update material" do
		put api_v1_course_lesson_material_url(@course, @lesson, @material),
		params: { title: "Atualizado" }.to_json,
		headers: @headers
		assert_response :success
	end

	test "should delete material" do
		assert_difference("Material.count", -1) do
		delete api_v1_course_lesson_material_url(@course, @lesson, @material), headers: @headers
		end
		assert_response :no_content
	end
end
