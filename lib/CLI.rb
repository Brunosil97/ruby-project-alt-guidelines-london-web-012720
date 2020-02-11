class CommandLineInterface
    def greet
        puts "
        ████████╗██╗  ██╗███████╗    ██╗    ██╗██╗████████╗ ██████╗██╗  ██╗███████╗██████╗     
        ╚══██╔══╝██║  ██║██╔════╝    ██║    ██║██║╚══██╔══╝██╔════╝██║  ██║██╔════╝██╔══██╗    
           ██║   ███████║█████╗      ██║ █╗ ██║██║   ██║   ██║     ███████║█████╗  ██████╔╝    
           ██║   ██╔══██║██╔══╝      ██║███╗██║██║   ██║   ██║     ██╔══██║██╔══╝  ██╔══██╗    
           ██║   ██║  ██║███████╗    ╚███╔███╔╝██║   ██║   ╚██████╗██║  ██║███████╗██║  ██║    
           ╚═╝   ╚═╝  ╚═╝╚══════╝     ╚══╝╚══╝ ╚═╝   ╚═╝    ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝   
          "
                                                                                                                              
                puts "==============================="
                puts    "Welcome to the Continent"
                puts "==============================="
    end 

    def name
        puts "===================="
        puts "Enter your username: "
        puts "===================="
        ans = gets.chomp
        @new_user = User.find_or_create_by(name: ans)
    end 

    def menu 
        puts "
            1. Create a new character 
            2. View your brave and mighty warriors 
            3. Gear Up
            4. Kill yourself
            5. Exit
        "

        puts "=================================================="
        puts "Please select from one of the options above: (1-5)"
        puts "=================================================="

        input = gets.chomp.to_i
        case input 
            when 1 
                self.new_character
                menu
            when 2
                self.view_warriors
                menu
            when 3
                self.gear_up
                menu
            when 4
                self.kys
                menu
            when 5
                puts "--------------------------------"
                puts "The Continent awaits your return"
                puts "--------------------------------"
            else
                puts "Invalid menu option, please try again"
        end
    end

    def new_character
        puts "---------------------------------------"
        puts "Please enter the name of your character"
        puts "---------------------------------------"
        ans_name = gets.chomp 
        puts "------------------------------------------"
        puts "Please enter the species of your character"
        puts "------------------------------------------"
        ans_species = gets.chomp 
        puts "-------------------------------------------------"
        puts "Please enter the health of your character (0-75)"
        puts "-------------------------------------------------"
        ans_health = gets.chomp 
        puts "---------------------------------------------------"
        puts "Please enter the strength of your character (0-75)"
        puts "---------------------------------------------------"
        ans_strength = gets.chomp 
        puts "--------------------------------------------------"
        puts "Please enter the defence of your character (0-75)"
        puts "--------------------------------------------------"
        ans_defence = gets.chomp

        @new_character = Character.find_or_create_by(name: ans_name, species: ans_species, health: ans_health, strength: ans_strength, defence: ans_defence, user_id: @new_user.id)
    end

    def view_warriors
        ux = User.find(@new_user.id)
        uw = ux.characters
        warriors = uw.map{|character| character.name }
        puts warriors
    end

    # def gear_up
    #     self.all.map{|weapon| weapon.name }
    #     puts "Which weapon would you like to equip?"
    #     ans = gets.chomp 
    #     ans_weapon = Weapon.find_by(name: ans)
    #     new_cw = CharacterWeapon.find_or_create_by(character_id: character.id, weapon_id: ans_weapon.id)
    # end

    def kys
        # ux = User.find(@new_user.id)
        # uw = ux.characters
        # warriors = uw.map{|character| character.name }
        # puts warriors 
        puts view_warriors
        puts "--------------------------------------------------"
        puts "Please choose the character you would like to kill"
        puts "--------------------------------------------------"
        ans_kill = gets.chomp  
        ans_kys = Character.find_by(name: ans_kill)
        if ans_kys.nil? 
            puts "------------------------------"
            puts "This character does not exist!"
            puts "------------------------------"
        else 
           ans_kys.destroy
            puts "--------------------------------------------------"
            puts "#{ans_kill} has tripped and fallen off a cliff!"
            puts "--------------------------------------------------"
        end 
    end
end 





