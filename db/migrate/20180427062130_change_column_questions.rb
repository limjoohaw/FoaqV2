class ChangeColumnQuestions < ActiveRecord::Migration[5.1]
  def change
  	remove_column :questions, :linkthumbnailer
  	add_column :questions, :linkthumbnailer, :jsonb, null: false, default: '{}'
	  add_index  :questions, :linkthumbnailer, using: :gin
  end
end
