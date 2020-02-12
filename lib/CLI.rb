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
            2. View your character Collection
            3. Gear Up
            4. End your suffering 
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
        puts "--------------------------"
        puts "These are your characters:"
        puts "--------------------------"
        i = 0 
        c = uw.map{|character| character} 
        while c.count > i 
            puts "#{c[i][:name]} - Species: #{c[i][:species]} - Health: #{c[i][:health]} - Strength #{c[i][:strength]} - Defence #{c[i][:defence]}"
            i += 1
        end 
        puts "-------------------------------------------------------------"
        

            
    end

    def gear_up
        view_warriors
            puts "-------------------------------------------"
            puts "Choose your character you'd like to upgrade"
            puts "-------------------------------------------"
        choice = gets.chomp
        char = Character.find_by(name: choice)

            i = 0
            w = Weapon.all.map{|weapon| weapon}
        while w.count > i
            puts "----------------------------------------------------------------------------"
            puts "Weapon: #{w[i][:name]} - #{w[i][:category]} - Health: #{w[i][:health]} - Strength: #{w[i][:strength]} - Defence: #{w[i][:defence]}"
            puts "----------------------------------------------------------------------------"
            i += 1
        end 
        
            puts "--------------------------------------------"
            puts "Which weapon would you like to equip? (name)"
            puts "--------------------------------------------"
        ans = gets.chomp 
        ans_weapon = Weapon.find_by(name: ans)
        new_health = char.health + ans_weapon.health
        new_strength = char.strength + ans_weapon.strength 
        new_defence = char.defence + ans_weapon.defence 

            puts "----------------------------------------------------"
            puts "#{char.name} now has #{new_health} health, #{new_strength} strength and #{new_defence} defence!"
            puts "----------------------------------------------------"

    end

    def kys
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





