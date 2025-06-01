require "test_helper"

class LessonTest < ActiveSupport::TestCase
  setup do
    @course = Course.create!(title: "Curso Teste", description: "Descrição", slug: "curso-teste")
  end

  test "should be valid with valid attributes" do
    lesson = Lesson.new(title: "Aula 1", course: @course)
    assert lesson.valid?
  end

  test "should be invalid without title" do
    lesson = Lesson.new(course: @course)
    assert_not lesson.valid?
    assert_includes lesson.errors[:title], "can't be blank"
  end

  test "should be invalid without course" do
    lesson = Lesson.new(title: "Sem curso")
    assert_not lesson.valid?
    assert_includes lesson.errors[:course], "must exist"
  end
end
