u1 = User.find_or_create_by(name: "Bruno")
u2 = User.find_or_create_by(name: "Ricky")

c1 = Character.find_or_create_by(name: "Geralt Of Riveia", species: "Human", health: 200, strength: 200, defence: 200, user_id: u1.id)
c2 = Character.find_or_create_by(name: "Yennefer Of Vengerberg", species: "Mixed", health: 100, strength: 150, defence: 300, user_id: u2.id)

w1 = Weapon.find_or_create_by(name: "Steel Sword", catagory: "Bladed Melee", health: 0, strength: 50, defence: 50)
w2 = Weapon.find_or_create_by(name: "Silver Sword", catagory: "Bladed Melee", health: 0, strength: 25, defence: 100)
w3 = Weapon.find_or_create_by(name: "Chaos", catagory: "Magic", health: -50, strength: 100, defence: 100)

cw1 = CharacterWeapon.find_or_create_by(character_id: c1.id, weapon_id: w1.id)
cw2 = CharacterWeapon.find_or_create_by(character_id: c1.id, weapon_id: w2.id)
cw3 = CharacterWeapon.find_or_create_by(character_id: c2.id, weapon_id: w3.id)

puts "SEEDED"
