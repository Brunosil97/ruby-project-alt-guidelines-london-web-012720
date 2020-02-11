class CommandLineInterface
    def greet
        puts "==============================="
        puts    "Welcome to the Continent"
        puts "==============================="
    end 

    def name
        puts "==================="
        puts "Enter your username: "
        puts "==================="
        ans = gets.chomp
        @new_user = User.find_or_create_by(name: ans)
    end 


end 





