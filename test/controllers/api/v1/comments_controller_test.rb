require "test_helper"

class Api::V1::CommentsControllerTest < ActionDispatch::IntegrationTest
	setup do
		@user = users(:one)
		@headers = auth_headers(@user)
		@course = Course.create!(title: "Curso", description: "Desc", slug: "curso")
		@lesson = Lesson.create!(title: "Aula", course: @course)
		@comment = Comment.create!(lesson: @lesson, user: @user, body: "Comentário")
	end

	test "should get index" do
		get api_v1_course_lesson_comments_url(@course, @lesson), headers: @headers
		assert_response :success
		assert_includes @response.body, @comment.body
	end

	# test "should show comment" do
	# 	get api_v1_course_lesson_comment_url(@course, @lesson, @comment), headers: @headers
	# 	assert_response :success
	# end

	test "should create comment" do
		assert_difference("Comment.count") do
		post api_v1_course_lesson_comments_url(@course, @lesson),
			params: { body: "Novo comentário" }.to_json,
			headers: @headers
		end
		assert_response :created
	end

	test "should not create comment without authentication" do
		post api_v1_course_lesson_comments_url(@course, @lesson),
		params: { body: "Coment sem login" }.to_json
		assert_response :unauthorized
	end

	# test "should update comment" do
	# 	put api_v1_course_lesson_comment_url(@course, @lesson, @comment),
	# 	params: { body: "Coment atualizado" }.to_json,
	# 	headers: @headers
	# 	assert_response :success
	# end

	test "should delete comment" do
		assert_difference("Comment.count", -1) do
		delete api_v1_course_lesson_comment_url(@course, @lesson, @comment), headers: @headers
		end
		assert_response :no_content
	end
end
