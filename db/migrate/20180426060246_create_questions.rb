class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
    	t.integer :user_id
    	t.string :title
    	t.text :description
    	t.string :source_url
    	t.integer :vote
    	t.jsonb :linkthumbnailer
      t.timestamps
    end
  end
end
