class CreateCourses < ActiveRecord::Migration[8.0]
	def change
		create_table :courses do |t|
			t.string :title
			t.text :description
			t.string :slug
			t.boolean :published, default: false, null: false

			t.timestamps
		end
		add_index :courses, :slug, unique: true
	end
end
