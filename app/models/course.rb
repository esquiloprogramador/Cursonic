class Course < ApplicationRecord
	has_many :lessons, dependent: :destroy
	has_many :enrollments, dependent: :destroy
	has_many :users, through: :enrollments

	validates :title, :description, :slug, presence: true
end