class ChangeColumnToCategory < ActiveRecord::Migration[5.1]
  def change
  	change_column :categories, :name, :string
  end
end
