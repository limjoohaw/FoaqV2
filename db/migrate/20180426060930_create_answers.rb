class CreateAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :answers do |t|
    	t.integer :user_id
    	t.integer :question_id
    	t.text :response
      t.timestamps
    end
  end
end
