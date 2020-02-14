class CommandLineInterface
    system "clear"
    def greet
        puts "
                    ████████╗██╗  ██╗███████╗    ██╗    ██╗██╗████████╗ ██████╗██╗  ██╗███████╗██████╗     
                    ╚══██╔══╝██║  ██║██╔════╝    ██║    ██║██║╚══██╔══╝██╔════╝██║  ██║██╔════╝██╔══██╗    
                       ██║   ███████║█████╗      ██║ █╗ ██║██║   ██║   ██║     ███████║█████╗  ██████╔╝    
                       ██║   ██╔══██║██╔══╝      ██║███╗██║██║   ██║   ██║     ██╔══██║██╔══╝  ██╔══██╗    
                       ██║   ██║  ██║███████╗    ╚███╔███╔╝██║   ██║   ╚██████╗██║  ██║███████╗██║  ██║    
                       ╚═╝   ╚═╝  ╚═╝╚══════╝     ╚══╝╚══╝ ╚═╝   ╚═╝    ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝   
          "
          system("sleep 1")
        puts TTY::Box.frame "WELCOME TO THE CONTINENT!", padding: 0.5, width: 50, top: 10, left: 35, align: :center, style: {
            fg: :red,
            bg: :black,
            border: {
                fg: :red,
                bg: :black
                    }
                }
    end 
                                                                                                                              
    def name
            system("sleep 1")
                puts "===================="
                puts "Enter your username: ".colorize(:red)
                puts "===================="
        ans = gets.chomp
        @new_user = User.find_or_create_by(name: ans)
        system("sleep 0.8")
        puts "-------------------"
        puts "Welcome #{@new_user.name}".colorize(:red)
        puts "-------------------"
        system("sleep 0.8")
    end 

    def menu 
        prompt = TTY::Prompt.new
        input = prompt.select("What would you like to do?", ['Create A New Character', 'View Your Character Collection', 'Gear Up', 'End Your Suffering', 'Log Out'])
        case input
            when 'Create A New Character'
                self.new_character
                menu
            when 'View Your Character Collection'
                self.view_warriors
                menu
            when 'Gear Up'
                self.gear_up
                menu
            when 'End Your Suffering'
                self.kys
                menu
            when 'Log Out'
                puts "--------------------------------"
                puts "The Continent awaits your return".colorize(:red)
                puts "--------------------------------"
            else
                puts "Invalid menu option, please try again"
        end
     end
       
    def new_character
            puts "---------------------------------------"
            puts "Please enter the name of your character".colorize(:yellow)
            puts "---------------------------------------"
        ans_name = gets.chomp
            puts "------------------------------------------"
            puts "Please enter the species of your character".colorize(:yellow)
            puts "------------------------------------------"
        ans_species = gets.chomp 
            puts "-------------------------------------------------"
            puts "Please enter the health of your character (0-75)".colorize(:yellow)
            puts "-------------------------------------------------"
        ans_health = gets.chomp.to_i.clamp(0, 75)
            puts "---------------------------------------------------"
            puts "Please enter the strength of your character (0-75)".colorize(:yellow)
            puts "---------------------------------------------------"
        ans_strength = gets.chomp.to_i.clamp(0, 75)
            puts "--------------------------------------------------"
            puts "Please enter the defence of your character (0-75)".colorize(:yellow)
            puts "--------------------------------------------------"
        ans_defence = gets.chomp.to_i.clamp(0,75)
        @new_character = Character.find_or_create_by(name: ans_name, species: ans_species, health: ans_health, strength: ans_strength, defence: ans_defence, user_id: @new_user.id)
        # pid = fork {exec "afplay", "lib/soundfile/character.mp3"}
    end

    def view_warriors
        ux = User.find(@new_user.id)
        uw = ux.characters
        system("sleep 0.8")
        puts "--------------------------"
        puts "These are your characters:".colorize(:red)
        puts "--------------------------"
        i = 0 
        c = uw.map{|character| character} 
        while c.count > i 
            puts "#{c[i][:name]} - Species: #{c[i][:species]} - Health: #{c[i][:health]} - Strength #{c[i][:strength]} - Defence #{c[i][:defence]}".colorize(:yellow)
            i += 1
        end 
        puts "-------------------------------------------------------------"    

    end

    def gear_up
        view_warriors
            puts "-------------------------------------------"
            puts "Choose your character you'd like to upgrade".colorize(:red)
            puts "-------------------------------------------"
        choice = gets.chomp
        char = Character.find_by(name: choice)
            if char.nil?
                puts "This character is not part of your team!".colorize(:yellow)
                menu 
            end
            i = 0
            w = Weapon.all.map{|weapon| weapon}
        while w.count > i
            puts "----------------------------------------------------------------------------"
            puts "Weapon: #{w[i][:name]} - #{w[i][:category]} - Health: #{w[i][:health]} - Strength: #{w[i][:strength]} - Defence: #{w[i][:defence]}".colorize(:yellow)
            puts "----------------------------------------------------------------------------"
            system("sleep 0.8")
            i += 1
        end 
            puts "--------------------------------------------"
            puts "Which weapon would you like to equip? (name)".colorize(:red)
            puts "============================================"
            puts "Be wary of your health".colorize(:red)
            puts "----------------------"
        ans = gets.chomp 
        ans_weapon = Weapon.find_by(name: ans)
            if ans_weapon.nil?
                puts "---------------------------------------"
                puts "This weapon is not currently available!".colorize(:red)
                puts "---------------------------------------"
                menu
            end 
            new_health = (char.health + ans_weapon.health).clamp(0, 1000)
            if new_health == 0 
                char.destroy
                puts "--------------------------------------------"
                puts "You have no health and have met your demise!".colorize(:red)
                puts "--------------------------------------------"
                menu
            end 
            new_strength = (char.strength + ans_weapon.strength).clamp(0, 1000)
            new_defence = (char.defence + ans_weapon.defence).clamp(0, 1000)
        CharacterWeapon.find_or_create_by(character_id: char.id, weapon_id: ans_weapon.id)
             char.update(health: new_health, strength: new_strength, defence: new_defence)
                puts "----------------------------------------------------"
                puts "#{char.name} now has #{new_health} health, #{new_strength} strength and #{new_defence} defence!".colorize(:red)
                puts "----------------------------------------------------"
            # pid = fork {exec "afplay", "lib/soundfile/level_up.mp3"}
    end

    def kys
            puts view_warriors
            puts "--------------------------------------------------"
            puts "Please choose the character you would like to kill".colorize(:blue)
            puts "--------------------------------------------------"
        ans_kill = gets.chomp  
        ans_kys = Character.find_by(name: ans_kill)
        if ans_kys.nil? 
            puts "-----------------------------------"
            puts "This character is not on your team!".colorize(:blue)
            puts "-----------------------------------"
        else 
           ans_kys.destroy
            puts "--------------------------------------------------"
            puts "#{ans_kill} has tripped and fallen off a cliff!".colorize(:blue)
            puts "--------------------------------------------------"
            pid = fork {exec "afplay", "lib/soundfile/respect.mp3"}
        end 
    end
end 





