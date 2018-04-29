class Votes < ActiveRecord::Migration[5.1]
	  def change
	  	create_table :votes do |t|
	  		t.integer :user_id
	  		t.integer :question_id
	  end
	end
end
