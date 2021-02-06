class CreatePlants < ActiveRecord::Migration[6.1]
  def change
    create_table :plants do |t|
      t.string :variety
      t.text :description 
      t.integer :user_id 
      t.integer :type_id
    end
  end
end
