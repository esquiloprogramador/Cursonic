class CreateMaterials < ActiveRecord::Migration[8.0]
	def change
		create_table :materials do |t|
			t.references :lesson, null: false, foreign_key: true
			t.string :title
			t.string :file_url
			t.string :kind

			t.timestamps
		end
	end
end
