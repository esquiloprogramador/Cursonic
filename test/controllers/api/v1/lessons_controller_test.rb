require "test_helper"

class Api::V1::LessonsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @headers = auth_headers(@user)
    @course = Course.create!(title: "Curso Teste", description: "Descrição", slug: "curso-teste")
    @lesson = Lesson.create!(title: "Aula Teste", course: @course)
  end

  test "should get index" do
    get api_v1_course_lessons_url(@course), headers: @headers
    assert_response :success
    assert_includes @response.body, @lesson.title
  end

  test "should show lesson" do
    get api_v1_course_lesson_url(@course, @lesson), headers: @headers
    assert_response :success
    assert_includes @response.body, @lesson.title
  end

  test "should return 404 for missing lesson" do
    get api_v1_course_lesson_url(@course, id: 9999), headers: @headers
    assert_response :not_found
  end

  test "should create lesson" do
    assert_difference("Lesson.count") do
      post api_v1_course_lessons_url(@course),
        params: { title: "Nova Aula" }.to_json,
        headers: @headers
    end
    assert_response :created
  end

  test "should not create invalid lesson" do
    post api_v1_course_lessons_url(@course),
      params: { title: "" }.to_json,
      headers: @headers
    assert_response :unprocessable_entity
  end

  test "should update lesson" do
    put api_v1_course_lesson_url(@course, @lesson),
      params: { title: "Atualizada" }.to_json,
      headers: @headers
    assert_response :success
    assert_match "Atualizada", @response.body
  end

  test "should delete lesson" do
    assert_difference("Lesson.count", -1) do
      delete api_v1_course_lesson_url(@course, @lesson), headers: @headers
    end
    assert_response :no_content
  end

	test "should not create lesson without authentication" do
		post api_v1_course_lessons_url(@course),
			params: { title: "Aula sem login" }.to_json
		assert_response :unauthorized
	end
end
