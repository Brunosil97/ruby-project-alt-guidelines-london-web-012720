class CreateCharacters < ActiveRecord::Migration[5.2]
  def change
    create_table :characters do |t|
      t.string :name
      t.string :species 
      t.integer :health 
      t.integer :strength 
      t.integer :defence 
      t.integer :user_id
    end 
  end
end
