require "test_helper"

class MaterialTest < ActiveSupport::TestCase
	setup do
		@course = Course.create!(title: "Curso", description: "Desc", slug: "curso")
		@lesson = Lesson.create!(title: "Aula", course: @course)
	end

	test "valid with valid attributes" do
		material = Material.new(lesson: @lesson, title: "PDF", kind: "pdf", file_url: "http://ex.com/file.pdf")
		assert material.valid?
	end

	test "invalid without lesson" do
		material = Material.new(title: "Sem aula")
		assert_not material.valid?
		assert_includes material.errors[:lesson], "must exist"
	end
end
