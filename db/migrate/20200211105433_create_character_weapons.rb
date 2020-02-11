class CreateCharacterWeapons < ActiveRecord::Migration[5.2]
  def change
    create_table :character_weapons do |t|
      t.integer :weapon_id 
      t.integer :character_id
    end 
  end
end
