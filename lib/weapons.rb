class Weapon < ActiveRecord::Base 
    has_many :character_weapons 
    has_many :characters, through: :character_weapons 
end 
