require_relative '../config/environment'
cli = CommandLineInterface.new


pid = fork {exec "afplay", "lib/soundfile/intro.mp3"}








cli.greet
cli.name

# user = User.new
# user.name
cli.menu
# chr = Character.new 
# chr.new_character
# chr.kys