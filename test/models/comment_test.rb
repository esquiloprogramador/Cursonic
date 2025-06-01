require "test_helper"

class CommentTest < ActiveSupport::TestCase
	setup do
		@course = Course.create!(title: "Curso", description: "Desc", slug: "curso")
		@lesson = Lesson.create!(title: "Aula", course: @course)
		@user = users(:one)
	end

	test "valid with valid attributes" do
		comment = Comment.new(lesson: @lesson, user: @user, body: "Comentário")
		assert comment.valid?
	end

	test "invalid without body" do
		comment = Comment.new(lesson: @lesson, user: @user)
		assert_not comment.valid?
		assert_includes comment.errors[:body], "can't be blank"
	end

	test "invalid without lesson or user" do
		comment1 = Comment.new(user: @user, body: "Test")
		comment2 = Comment.new(lesson: @lesson, body: "Test")
		assert_not comment1.valid?
		assert_not comment2.valid?
	end
end
