require "test_helper"

class EnrollmentTest < ActiveSupport::TestCase
	setup do
		@course = Course.create!(title: "Curso", description: "Desc", slug: "curso")
		@user = users(:one)
	end

	test "valid with user and course" do
		enrollment = Enrollment.new(user: @user, course: @course)
		assert enrollment.valid?
	end

	test "invalid without user or course" do
		enrollment1 = Enrollment.new(course: @course)
		enrollment2 = Enrollment.new(user: @user)
		assert_not enrollment1.valid?
		assert_not enrollment2.valid?
	end

	test "should not allow duplicate enrollment" do
		Enrollment.create!(user: @user, course: @course)
		duplicate = Enrollment.new(user: @user, course: @course)
		assert_not duplicate.valid?
	end
end
