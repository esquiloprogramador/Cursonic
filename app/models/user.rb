class User < ApplicationRecord
	has_secure_password
	has_many :enrollments
	has_many :courses, through: :enrollments
	has_many :comments
end