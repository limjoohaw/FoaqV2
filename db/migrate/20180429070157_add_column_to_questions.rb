class AddColumnToQuestions < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :category_id, :integer
  	add_index :questions, :category_id
  end
end
