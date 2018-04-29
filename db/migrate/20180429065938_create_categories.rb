class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
    	t.integer :question_id
    	t.integer :name
      t.timestamps
    end
  end
end
