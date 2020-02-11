class Character < ActiveRecord::Base 
    has_many :character_weapons 
    has_many :weapons, through: :character_weapons 
    belongs_to :user

    
end 