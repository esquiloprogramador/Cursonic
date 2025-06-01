require "test_helper"

class CourseTest < ActiveSupport::TestCase
	test "should be valid with valid attributes" do
		course = Course.new(title: "Curso de Rails", description: "Aprenda Rails", slug:"curso-rails")
		assert course.valid?
	end

	test "should be invalid without title" do
		course = Course.new(description: "Descrição sem título")
		assert_not course.valid?
		assert_includes course.errors[:title], "can't be blank"
	end

	test "should be invalid without description" do
		course = Course.new(title: "Sem descrição")
		assert_not course.valid?
		assert_includes course.errors[:description], "can't be blank"
	end
end
