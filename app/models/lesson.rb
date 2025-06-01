class Lesson < ApplicationRecord
	belongs_to :course
	has_many :comments, dependent: :destroy
	has_many :materials, dependent: :destroy

	validates :title, presence: true
end
